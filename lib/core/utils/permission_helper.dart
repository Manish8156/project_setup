import 'package:permission_handler/permission_handler.dart';

import 'app_common_imports.dart';

class PermissionHelper {
  PermissionHelper(PermissionType permissionType) {
    _permissionType = permissionType;
  }

  /// Permission type to request permission from user
  PermissionType? _permissionType;

  /// callback when permission is denied by user
  Function()? _onPermissionDenied;

  /// callback when permission is granted by user
  Function()? _onPermissionGranted;

  /// callback when permission is permanently denied by user
  Function()? _onPermissionPermanentlyDenied;

  /// request a [permission], onPermissionGranted method to handle when permission is granted
  PermissionHelper onPermissionGranted(Function()? onPermissionGranted) {
    _onPermissionGranted = onPermissionGranted;
    return this;
  }

  /// on permissionDenied method to handle when permission is denied
  PermissionHelper onPermissionDenied(Function()? onPermissionDenied) {
    _onPermissionDenied = onPermissionDenied;
    return this;
  }

  /// on permissionPermanentlyDenied method to handle when permission is permanently denied
  PermissionHelper onPermissionPermanentlyDenied(Function()? onPermissionPermanentlyDenied) {
    _onPermissionPermanentlyDenied = onPermissionPermanentlyDenied;
    return this;
  }

  /// get Permission type
  Permission _getPermissionFromType(PermissionType permissionType) {
    switch (permissionType) {
      case PermissionType.camera:
        return Permission.camera;
      case PermissionType.storage:
        return Permission.storage;
      case PermissionType.recordAudio:
        return Permission.microphone;
      case PermissionType.writeContacts:
        return Permission.contacts;
      case PermissionType.readContacts:
        return Permission.contacts;
      case PermissionType.whenInUseLocation:
        return Permission.locationWhenInUse;
      case PermissionType.alwaysLocation:
        return Permission.locationAlways;
      case PermissionType.notification:
        return Permission.notification;
      case PermissionType.photos:
        return Permission.photos;
      default:
        throw Exception('Invalid permission type');
    }
  }

  /// get permissionType from the [_getPermissionFromType] and request the permission
  void execute() async {
    Permission permission = _getPermissionFromType(_permissionType!);

    if (permission == Permission.locationWhenInUse ||
        permission == Permission.locationAlways ||
        permission == Permission.location) {
      await permission.shouldShowRequestRationale;
    }

    PermissionStatus status = await permission.request();
    debugPrint('permission status :: $status');

    if (status.isGranted) {
      if (_onPermissionGranted != null) {
        _onPermissionGranted!();
      }
    } else if (status.isDenied) {
      if (_onPermissionDenied != null) {
        _onPermissionDenied!();
      }
    } else if (status.isPermanentlyDenied) {
      if (_onPermissionPermanentlyDenied != null) {
        _onPermissionPermanentlyDenied!();
      }
    }
  }
}
