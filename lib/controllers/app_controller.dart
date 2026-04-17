import 'package:flutter/material.dart';
import 'package:media_drive_with_flutter/models/api_models.dart';
import 'package:media_drive_with_flutter/services/api_service.dart';

class AppController extends ChangeNotifier {
  AppController({
    ApiService? apiService,
  }) : _apiService = apiService ?? ApiService();

  final ApiService _apiService;

  String baseUrl = 'https://media-drive-backend-one.vercel.app';
  String ownerEmail = '';

  HealthStatus? healthStatus;
  ReadyStatus? readyStatus;
  OtpSendResult? lastOtpSend;
  OtpVerifyResult? lastOtpVerification;

  bool isLoadingHealth = false;
  bool isSendingOtp = false;
  bool isVerifyingOtp = false;
  bool isLoadingFolders = false;
  bool isLoadingFolderDetails = false;
  bool isMutating = false;

  String? healthError;
  String? otpError;
  String? folderError;
  String? mutationMessage;

  List<FolderNode> rootFolders = const [];
  FolderDetails? selectedFolderDetails;
  String? selectedFolderId;
  BulkCreateItemsResult? lastBulkCreate;
  BulkDeleteItemsResult? lastBulkDelete;

  void updateBaseUrl(String value) {
    baseUrl = value.trim().isEmpty
        ? 'https://media-drive-backend-one.vercel.app'
        : value.trim();
    notifyListeners();
  }

  void updateOwnerEmail(String value) {
    ownerEmail = value.trim();
    notifyListeners();
  }

  Future<void> refreshHealth() async {
    isLoadingHealth = true;
    healthError = null;
    notifyListeners();

    try {
      healthStatus = await _apiService.fetchHealth(baseUrl: baseUrl);
      readyStatus = await _apiService.fetchReady(baseUrl: baseUrl);
    } on ApiException catch (error) {
      healthError = error.message;
    } catch (error) {
      healthError = error.toString();
    } finally {
      isLoadingHealth = false;
      notifyListeners();
    }
  }

  Future<void> sendOtp({
    required String email,
    required String purpose,
  }) async {
    isSendingOtp = true;
    otpError = null;
    mutationMessage = null;
    notifyListeners();

    try {
      lastOtpSend = await _apiService.sendOtp(
        baseUrl: baseUrl,
        email: email.trim(),
        purpose: purpose,
      );
      ownerEmail = email.trim();
      mutationMessage = lastOtpSend?.message;
    } on ApiException catch (error) {
      otpError = error.message;
    } catch (error) {
      otpError = error.toString();
    } finally {
      isSendingOtp = false;
      notifyListeners();
    }
  }

  Future<void> verifyOtp({
    required String email,
    required String otp,
  }) async {
    isVerifyingOtp = true;
    otpError = null;
    mutationMessage = null;
    notifyListeners();

    try {
      lastOtpVerification = await _apiService.verifyOtp(
        baseUrl: baseUrl,
        email: email.trim(),
        otp: otp.trim(),
      );
      ownerEmail = email.trim();
      mutationMessage = lastOtpVerification?.message;
    } on ApiException catch (error) {
      otpError = error.message;
    } catch (error) {
      otpError = error.toString();
    } finally {
      isVerifyingOtp = false;
      notifyListeners();
    }
  }

  Future<void> loadRootFolders() async {
    if (ownerEmail.isEmpty) {
      folderError = 'Set an owner email first.';
      notifyListeners();
      return;
    }

    isLoadingFolders = true;
    folderError = null;
    notifyListeners();

    try {
      rootFolders = await _apiService.getRootFolders(
        baseUrl: baseUrl,
        ownerEmail: ownerEmail,
      );
    } on ApiException catch (error) {
      folderError = error.message;
    } catch (error) {
      folderError = error.toString();
    } finally {
      isLoadingFolders = false;
      notifyListeners();
    }
  }

  Future<void> loadFolderDetails(String folderId) async {
    selectedFolderId = folderId;
    isLoadingFolderDetails = true;
    folderError = null;
    notifyListeners();

    try {
      selectedFolderDetails = await _apiService.getFolderDetails(
        baseUrl: baseUrl,
        ownerEmail: ownerEmail,
        folderId: folderId,
      );
    } on ApiException catch (error) {
      folderError = error.message;
    } catch (error) {
      folderError = error.toString();
    } finally {
      isLoadingFolderDetails = false;
      notifyListeners();
    }
  }

  Future<void> createFolder({
    required String name,
    String? parentId,
  }) async {
    await _runMutation(() async {
      final folder = await _apiService.createFolder(
        baseUrl: baseUrl,
        ownerEmail: ownerEmail,
        name: name,
        parentId: parentId,
      );
      mutationMessage = 'Folder "${folder.name}" created.';
      await loadRootFolders();
      if (parentId != null) {
        await loadFolderDetails(parentId);
      }
    });
  }

  Future<void> renameFolder({
    required String folderId,
    required String name,
  }) async {
    await _runMutation(() async {
      final folder = await _apiService.renameFolder(
        baseUrl: baseUrl,
        ownerEmail: ownerEmail,
        folderId: folderId,
        name: name,
      );
      mutationMessage = 'Folder renamed to "${folder.name}".';
      await loadRootFolders();
      if (selectedFolderId == folderId) {
        await loadFolderDetails(folderId);
      } else if (selectedFolderId != null) {
        await loadFolderDetails(selectedFolderId!);
      }
    });
  }

  Future<void> moveFolder({
    required String folderId,
    String? newParentId,
  }) async {
    await _runMutation(() async {
      await _apiService.moveFolder(
        baseUrl: baseUrl,
        ownerEmail: ownerEmail,
        folderId: folderId,
        newParentId: newParentId,
      );
      mutationMessage = 'Folder moved successfully.';
      await loadRootFolders();
      if (selectedFolderId != null) {
        await loadFolderDetails(selectedFolderId!);
      }
    });
  }

  Future<void> deleteFolder(String folderId) async {
    await _runMutation(() async {
      await _apiService.deleteFolder(
        baseUrl: baseUrl,
        ownerEmail: ownerEmail,
        folderId: folderId,
      );
      mutationMessage = 'Folder deleted.';
      await loadRootFolders();
      if (selectedFolderId == folderId) {
        selectedFolderId = null;
        selectedFolderDetails = null;
      } else if (selectedFolderId != null) {
        await loadFolderDetails(selectedFolderId!);
      }
    });
  }

  Future<void> createItem({
    required String folderId,
    required String name,
    required String url,
    required String mime,
    required int size,
    required String kind,
  }) async {
    await _runMutation(() async {
      final item = await _apiService.createItem(
        baseUrl: baseUrl,
        ownerEmail: ownerEmail,
        folderId: folderId,
        name: name,
        url: url,
        mime: mime,
        size: size,
        kind: kind,
      );
      mutationMessage = 'Item "${item.name}" created.';
      await loadFolderDetails(folderId);
    });
  }

  Future<void> bulkCreateItems(List<Map<String, dynamic>> items) async {
    await _runMutation(() async {
      lastBulkCreate = await _apiService.bulkCreateItems(
        baseUrl: baseUrl,
        ownerEmail: ownerEmail,
        items: items,
      );
      mutationMessage = lastBulkCreate!.partial
          ? 'Bulk create finished with partial success.'
          : 'Bulk create finished successfully.';
      if (selectedFolderId != null) {
        await loadFolderDetails(selectedFolderId!);
      }
      await loadRootFolders();
    });
  }

  Future<void> updateItem({
    required String itemId,
    String? name,
    String? folderId,
  }) async {
    await _runMutation(() async {
      final item = await _apiService.updateItem(
        baseUrl: baseUrl,
        ownerEmail: ownerEmail,
        itemId: itemId,
        name: name,
        folderId: folderId,
      );
      mutationMessage = 'Item "${item.name}" updated.';
      if (selectedFolderId != null) {
        await loadFolderDetails(selectedFolderId!);
      }
    });
  }

  Future<void> deleteItem(String itemId) async {
    await _runMutation(() async {
      await _apiService.deleteItem(
        baseUrl: baseUrl,
        ownerEmail: ownerEmail,
        itemId: itemId,
      );
      mutationMessage = 'Item deleted.';
      if (selectedFolderId != null) {
        await loadFolderDetails(selectedFolderId!);
      }
    });
  }

  Future<void> bulkDeleteItems(List<String> ids) async {
    await _runMutation(() async {
      lastBulkDelete = await _apiService.bulkDeleteItems(
        baseUrl: baseUrl,
        ownerEmail: ownerEmail,
        ids: ids,
      );
      mutationMessage =
          'Bulk delete removed ${lastBulkDelete!.deleted} item(s).';
      if (selectedFolderId != null) {
        await loadFolderDetails(selectedFolderId!);
      }
    });
  }

  Future<void> _runMutation(Future<void> Function() action) async {
    if (ownerEmail.isEmpty) {
      folderError = 'Set an owner email first.';
      notifyListeners();
      return;
    }

    isMutating = true;
    folderError = null;
    mutationMessage = null;
    notifyListeners();

    try {
      await action();
    } on ApiException catch (error) {
      folderError = error.message;
    } catch (error) {
      folderError = error.toString();
    } finally {
      isMutating = false;
      notifyListeners();
    }
  }
}

class AppControllerScope extends InheritedNotifier<AppController> {
  const AppControllerScope({
    required AppController controller,
    required super.child,
    super.key,
  }) : super(notifier: controller);

  static AppController of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<AppControllerScope>();
    assert(scope != null, 'AppControllerScope not found in widget tree.');
    return scope!.notifier!;
  }
}

extension AppControllerContext on BuildContext {
  AppController get appController => AppControllerScope.of(this);
}
