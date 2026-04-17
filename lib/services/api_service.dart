import 'dart:convert';
import 'dart:io';

import 'package:media_drive_with_flutter/models/api_models.dart';

class ApiException implements Exception {
  const ApiException({
    required this.statusCode,
    required this.message,
    this.details,
  });

  final int statusCode;
  final String message;
  final Object? details;

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class ApiService {
  ApiService({
    HttpClient? client,
  }) : _client = client ?? HttpClient();

  final HttpClient _client;

  Future<HealthStatus> fetchHealth({
    required String baseUrl,
  }) async {
    final json = await _requestJson(
      method: 'GET',
      baseUrl: baseUrl,
      path: '/healthz',
    );
    return HealthStatus.fromJson(json as Map<String, dynamic>);
  }

  Future<ReadyStatus> fetchReady({
    required String baseUrl,
  }) async {
    final json = await _requestJson(
      method: 'GET',
      baseUrl: baseUrl,
      path: '/readyz',
    );
    return ReadyStatus.fromJson(json as Map<String, dynamic>);
  }

  Future<OtpSendResult> sendOtp({
    required String baseUrl,
    required String email,
    required String purpose,
  }) async {
    final json = await _requestJson(
      method: 'POST',
      baseUrl: baseUrl,
      path: '/otp/send',
      body: {
        'email': email,
        'purpose': purpose,
      },
    );
    return OtpSendResult.fromJson(json as Map<String, dynamic>);
  }

  Future<OtpVerifyResult> verifyOtp({
    required String baseUrl,
    required String email,
    required String otp,
  }) async {
    final json = await _requestJson(
      method: 'POST',
      baseUrl: baseUrl,
      path: '/otp/verify',
      body: {
        'email': email,
        'otp': otp,
      },
    );
    return OtpVerifyResult.fromJson(json as Map<String, dynamic>);
  }

  Future<List<FolderNode>> getRootFolders({
    required String baseUrl,
    required String ownerEmail,
  }) async {
    final json = await _requestJson(
      method: 'GET',
      baseUrl: baseUrl,
      path: '/folders',
      ownerEmail: ownerEmail,
    );
    return (json as List<dynamic>)
        .map((value) => FolderNode.fromJson(value as Map<String, dynamic>))
        .toList();
  }

  Future<FolderNode> createFolder({
    required String baseUrl,
    required String ownerEmail,
    required String name,
    String? parentId,
  }) async {
    final json = await _requestJson(
      method: 'POST',
      baseUrl: baseUrl,
      path: '/folders',
      ownerEmail: ownerEmail,
      body: {
        'name': name,
        'parentId': parentId,
      },
    );
    return FolderNode.fromJson(json as Map<String, dynamic>);
  }

  Future<FolderDetails> getFolderDetails({
    required String baseUrl,
    required String ownerEmail,
    required String folderId,
  }) async {
    final json = await _requestJson(
      method: 'GET',
      baseUrl: baseUrl,
      path: '/folders/$folderId',
      ownerEmail: ownerEmail,
    );
    return FolderDetails.fromJson(json as Map<String, dynamic>);
  }

  Future<FolderNode> renameFolder({
    required String baseUrl,
    required String ownerEmail,
    required String folderId,
    required String name,
  }) async {
    final json = await _requestJson(
      method: 'PATCH',
      baseUrl: baseUrl,
      path: '/folders/$folderId',
      ownerEmail: ownerEmail,
      body: {'name': name},
    );
    return FolderNode.fromJson(json as Map<String, dynamic>);
  }

  Future<void> moveFolder({
    required String baseUrl,
    required String ownerEmail,
    required String folderId,
    String? newParentId,
  }) async {
    await _requestJson(
      method: 'PATCH',
      baseUrl: baseUrl,
      path: '/folders/$folderId/move',
      ownerEmail: ownerEmail,
      body: {'newParentId': newParentId},
    );
  }

  Future<void> deleteFolder({
    required String baseUrl,
    required String ownerEmail,
    required String folderId,
  }) async {
    await _requestJson(
      method: 'DELETE',
      baseUrl: baseUrl,
      path: '/folders/$folderId',
      ownerEmail: ownerEmail,
    );
  }

  Future<MediaItem> createItem({
    required String baseUrl,
    required String ownerEmail,
    required String folderId,
    required String name,
    required String url,
    required String mime,
    required int size,
    required String kind,
  }) async {
    final json = await _requestJson(
      method: 'POST',
      baseUrl: baseUrl,
      path: '/items',
      ownerEmail: ownerEmail,
      body: {
        'folderId': folderId,
        'name': name,
        'url': url,
        'mime': mime,
        'size': size,
        'kind': kind,
      },
    );
    return MediaItem.fromJson(json as Map<String, dynamic>);
  }

  Future<BulkCreateItemsResult> bulkCreateItems({
    required String baseUrl,
    required String ownerEmail,
    required List<Map<String, dynamic>> items,
  }) async {
    final response = await _requestRaw(
      method: 'POST',
      baseUrl: baseUrl,
      path: '/items/bulk',
      ownerEmail: ownerEmail,
      body: {'items': items},
    );
    final json = _decodeResponse(response.body);
    _throwIfError(response.statusCode, json);
    return BulkCreateItemsResult.fromJson(json as Map<String, dynamic>);
  }

  Future<MediaItem> updateItem({
    required String baseUrl,
    required String ownerEmail,
    required String itemId,
    String? name,
    String? folderId,
  }) async {
    final body = <String, dynamic>{};
    if (name != null && name.isNotEmpty) {
      body['name'] = name;
    }
    if (folderId != null && folderId.isNotEmpty) {
      body['folderId'] = folderId;
    }

    final json = await _requestJson(
      method: 'PATCH',
      baseUrl: baseUrl,
      path: '/items/$itemId',
      ownerEmail: ownerEmail,
      body: body,
    );
    return MediaItem.fromJson(json as Map<String, dynamic>);
  }

  Future<void> deleteItem({
    required String baseUrl,
    required String ownerEmail,
    required String itemId,
  }) async {
    await _requestJson(
      method: 'DELETE',
      baseUrl: baseUrl,
      path: '/items/$itemId',
      ownerEmail: ownerEmail,
    );
  }

  Future<BulkDeleteItemsResult> bulkDeleteItems({
    required String baseUrl,
    required String ownerEmail,
    required List<String> ids,
  }) async {
    final json = await _requestJson(
      method: 'DELETE',
      baseUrl: baseUrl,
      path: '/items/bulk',
      ownerEmail: ownerEmail,
      body: {'ids': ids},
    );
    return BulkDeleteItemsResult.fromJson(json as Map<String, dynamic>);
  }

  Future<dynamic> _requestJson({
    required String method,
    required String baseUrl,
    required String path,
    String? ownerEmail,
    Map<String, dynamic>? body,
  }) async {
    final response = await _requestRaw(
      method: method,
      baseUrl: baseUrl,
      path: path,
      ownerEmail: ownerEmail,
      body: body,
    );
    final json = _decodeResponse(response.body);
    _throwIfError(response.statusCode, json);
    return json;
  }

  Future<_ApiRawResponse> _requestRaw({
    required String method,
    required String baseUrl,
    required String path,
    String? ownerEmail,
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse(baseUrl).resolve(path);
    final request = await _client.openUrl(method, uri);

    request.headers.set(HttpHeaders.acceptHeader, 'application/json');
    request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
    if (ownerEmail != null && ownerEmail.isNotEmpty) {
      request.headers.set('x-user-email', ownerEmail);
    }
    if (body != null) {
      request.write(jsonEncode(body));
    }

    final response = await request.close();
    final responseBody = await utf8.decodeStream(response);
    return _ApiRawResponse(
      statusCode: response.statusCode,
      body: responseBody,
    );
  }

  dynamic _decodeResponse(String body) {
    if (body.trim().isEmpty) {
      return <String, dynamic>{};
    }
    return jsonDecode(body);
  }

  void _throwIfError(int statusCode, dynamic json) {
    if (statusCode >= 200 && statusCode < 300) {
      return;
    }

    if (json is Map<String, dynamic>) {
      throw ApiException(
        statusCode: statusCode,
        message: json['message']?.toString() ??
            json['error']?.toString() ??
            'Request failed',
        details: json['details'],
      );
    }

    throw ApiException(
      statusCode: statusCode,
      message: 'Request failed with status $statusCode',
    );
  }
}

class _ApiRawResponse {
  const _ApiRawResponse({
    required this.statusCode,
    required this.body,
  });

  final int statusCode;
  final String body;
}
