class HealthStatus {
  const HealthStatus({
    required this.status,
    required this.uptime,
    required this.pid,
    required this.db,
    required this.timestamp,
  });

  final String status;
  final double uptime;
  final int pid;
  final String db;
  final String timestamp;

  factory HealthStatus.fromJson(Map<String, dynamic> json) {
    return HealthStatus(
      status: json['status']?.toString() ?? 'unknown',
      uptime: (json['uptime'] as num?)?.toDouble() ?? 0,
      pid: (json['pid'] as num?)?.toInt() ?? 0,
      db: json['db']?.toString() ?? 'unknown',
      timestamp: json['timestamp']?.toString() ?? '',
    );
  }
}

class ReadyStatus {
  const ReadyStatus({
    required this.status,
    required this.db,
  });

  final String status;
  final String db;

  factory ReadyStatus.fromJson(Map<String, dynamic> json) {
    return ReadyStatus(
      status: json['status']?.toString() ?? 'unknown',
      db: json['db']?.toString() ?? 'unknown',
    );
  }
}

class FolderNode {
  const FolderNode({
    required this.id,
    required this.owner,
    required this.name,
    required this.parent,
    required this.ancestors,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String owner;
  final String name;
  final String? parent;
  final List<String> ancestors;
  final String createdAt;
  final String updatedAt;

  factory FolderNode.fromJson(Map<String, dynamic> json) {
    return FolderNode(
      id: json['_id']?.toString() ?? '',
      owner: json['owner']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      parent: json['parent']?.toString(),
      ancestors: (json['ancestors'] as List<dynamic>? ?? const [])
          .map((value) => value.toString())
          .toList(),
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
    );
  }
}

class MediaItem {
  const MediaItem({
    required this.id,
    required this.owner,
    required this.folder,
    required this.name,
    required this.url,
    required this.mime,
    required this.size,
    required this.kind,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String owner;
  final String folder;
  final String name;
  final String url;
  final String mime;
  final int size;
  final String kind;
  final String createdAt;
  final String updatedAt;

  factory MediaItem.fromJson(Map<String, dynamic> json) {
    return MediaItem(
      id: json['_id']?.toString() ?? '',
      owner: json['owner']?.toString() ?? '',
      folder: json['folder']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      url: json['url']?.toString() ?? '',
      mime: json['mime']?.toString() ?? '',
      size: (json['size'] as num?)?.toInt() ?? 0,
      kind: json['kind']?.toString() ?? 'file',
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
    );
  }
}

class FolderDetails {
  const FolderDetails({
    required this.folder,
    required this.children,
    required this.items,
  });

  final FolderNode folder;
  final List<FolderNode> children;
  final List<MediaItem> items;

  factory FolderDetails.fromJson(Map<String, dynamic> json) {
    return FolderDetails(
      folder: FolderNode.fromJson(json['folder'] as Map<String, dynamic>),
      children: (json['children'] as List<dynamic>? ?? const [])
          .map((value) => FolderNode.fromJson(value as Map<String, dynamic>))
          .toList(),
      items: (json['items'] as List<dynamic>? ?? const [])
          .map((value) => MediaItem.fromJson(value as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ApiResponseMessage {
  const ApiResponseMessage({
    required this.message,
  });

  final String message;

  factory ApiResponseMessage.fromJson(Map<String, dynamic> json) {
    return ApiResponseMessage(
      message: json['message']?.toString() ?? '',
    );
  }
}

class OtpSendResult {
  const OtpSendResult({
    required this.email,
    required this.message,
    required this.messageId,
    required this.from,
  });

  final String email;
  final String message;
  final String messageId;
  final String from;

  factory OtpSendResult.fromJson(Map<String, dynamic> json) {
    return OtpSendResult(
      email: json['email']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      messageId: json['messageId']?.toString() ?? '',
      from: json['from']?.toString() ?? '',
    );
  }
}

class OtpVerifyResult {
  const OtpVerifyResult({
    required this.email,
    required this.message,
    required this.purpose,
  });

  final String email;
  final String message;
  final String purpose;

  factory OtpVerifyResult.fromJson(Map<String, dynamic> json) {
    return OtpVerifyResult(
      email: json['email']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      purpose: json['purpose']?.toString() ?? '',
    );
  }
}

class BulkCreateItemsResult {
  const BulkCreateItemsResult({
    required this.ok,
    required this.partial,
    required this.inserted,
    required this.total,
    required this.failed,
    required this.items,
    required this.errors,
  });

  final bool ok;
  final bool partial;
  final int inserted;
  final int total;
  final int failed;
  final List<MediaItem> items;
  final List<Map<String, dynamic>> errors;

  factory BulkCreateItemsResult.fromJson(Map<String, dynamic> json) {
    return BulkCreateItemsResult(
      ok: json['ok'] == true,
      partial: json['partial'] == true,
      inserted: (json['inserted'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toInt() ?? 0,
      failed: (json['failed'] as num?)?.toInt() ?? 0,
      items: (json['items'] as List<dynamic>? ?? const [])
          .map((value) => MediaItem.fromJson(value as Map<String, dynamic>))
          .toList(),
      errors: (json['errors'] as List<dynamic>? ?? const [])
          .map((value) => Map<String, dynamic>.from(value as Map))
          .toList(),
    );
  }
}

class BulkDeleteItemsResult {
  const BulkDeleteItemsResult({
    required this.ok,
    required this.attempted,
    required this.deleted,
  });

  final bool ok;
  final int attempted;
  final int deleted;

  factory BulkDeleteItemsResult.fromJson(Map<String, dynamic> json) {
    return BulkDeleteItemsResult(
      ok: json['ok'] == true,
      attempted: (json['attempted'] as num?)?.toInt() ?? 0,
      deleted: (json['deleted'] as num?)?.toInt() ?? 0,
    );
  }
}
