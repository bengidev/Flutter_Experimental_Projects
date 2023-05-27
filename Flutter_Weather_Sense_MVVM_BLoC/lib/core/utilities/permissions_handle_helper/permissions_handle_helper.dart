import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

@immutable
class PermissionsHandleHelper {
  /// Test the static [requestPermissions] method
  /// of the [PermissionsHandleHelper]'s class.
  ///
  /// It will return the results from [requestPermissions].
  ///
  /// This method only available for testing purpose only.
  @visibleForTesting
  Future<Map<Permission, PermissionStatus>> testRequestPermissions({
    required List<Permission> permissions,
  }) {
    return PermissionsHandleHelper.requestPermissions(permissions: permissions);
  }

  /// Requests the user for accessing the system device functionalities
  /// through these [permissions].
  ///
  /// It will returns a Map of Future<Map<Permission, PermissionStatus>>
  /// containing the [PermissionStatus] per requested Permission,
  /// if they haven't already been granted before..
  static Future<Map<Permission, PermissionStatus>> requestPermissions({
    required List<Permission> permissions,
  }) async {
    return permissions.request();
  }

  /// Test the static [checkCurrentStatusPermissions] method
  /// of the [PermissionsHandleHelper]'s class.
  ///
  /// It will return the results from [checkCurrentStatusPermissions].
  ///
  /// This method only available for testing purpose only.
  @visibleForTesting
  Future<Map<String, PermissionStatus>> testCheckCurrentStatusPermissions({
    required List<Permission> permissions,
  }) {
    return PermissionsHandleHelper.checkCurrentStatusPermissions(
        permissions: permissions);
  }

  /// Checks for each of current status [permissions] to get access into
  /// the system device functionalities.
  ///
  /// It will returns a Map of Future<Map<String, PermissionStatus>>
  /// containing the [String] of [Permission]'s name,
  /// and [PermissionStatus]' result per requested Permission.
  static Future<Map<String, PermissionStatus>> checkCurrentStatusPermissions({
    required List<Permission> permissions,
  }) async {
    final permissionStatuses = <String, PermissionStatus>{};
    for (var i = 0; i < permissions.length; i++) {
      final currentPermission = permissions.elementAt(i).toString();
      final statusResult = await permissions.elementAt(i).status;

      permissionStatuses.addAll({currentPermission: statusResult});
    }

    return permissionStatuses;
  }

  /// Test the static [checkAssociatedServiceStatusPermissions] method
  /// of the [PermissionsHandleHelper]'s class.
  ///
  /// It will return the results from [checkAssociatedServiceStatusPermissions].
  ///
  /// This method only available for testing purpose only.
  @visibleForTesting
  Future<Map<String, ServiceStatus>>
      testCheckAssociatedServiceStatusPermissions({
    required List<PermissionWithService> permissionServices,
  }) {
    return PermissionsHandleHelper.checkAssociatedServiceStatusPermissions(
        permissionServices: permissionServices);
  }

  /// Checks the availability of Associated Service Status
  /// for each of [permissionServices] to get access into
  /// the system device functionalities.
  ///
  /// It will returns a Map of Future<Map<String, ServiceStatus>>
  /// containing the [String] of [PermissionWithService]'s name,
  /// and [ServiceStatus]' result per requested Permission.
  static Future<Map<String, ServiceStatus>>
      checkAssociatedServiceStatusPermissions({
    required List<PermissionWithService> permissionServices,
  }) async {
    final permissionStatuses = <String, ServiceStatus>{};
    for (var i = 0; i < permissionServices.length; i++) {
      final currentPermission = permissionServices.elementAt(i).toString();
      final statusResult = await permissionServices.elementAt(i).serviceStatus;

      permissionStatuses.addAll({currentPermission: statusResult});
    }

    return permissionStatuses;
  }

  /// Test the static [checkShouldShowRequestRationalePermissions] method
  /// of the [PermissionsHandleHelper]'s class.
  ///
  /// It will return the results from [checkShouldShowRequestRationalePermissions].
  ///
  /// This method only available for testing purpose only.
  @visibleForTesting
  Future<Map<String, bool>> testCheckShouldShowRequestRationalePermissions({
    required List<Permission> permissions,
  }) {
    return PermissionsHandleHelper.checkShouldShowRequestRationalePermissions(
        permissions: permissions);
  }

  /// Checks when it should show request rationale permissions
  /// for Android Platform's case or not.
  ///
  /// It will decide to show request rationale permissions
  /// when user was rejected or denied the first set of
  /// requested permissions.
  ///
  /// It will returns a Map of Future<Map<String, bool>>
  /// containing the [String] of [Permission]'s name,
  /// and the results of [bool] per requested Permission.
  static Future<Map<String, bool>> checkShouldShowRequestRationalePermissions({
    required List<Permission> permissions,
  }) async {
    final permissionStatuses = <String, bool>{};
    for (var i = 0; i < permissions.length; i++) {
      final currentPermission = permissions.elementAt(i).toString();
      final statusResult =
          await permissions.elementAt(i).shouldShowRequestRationale;

      permissionStatuses.addAll({currentPermission: statusResult});
    }

    return permissionStatuses;
  }
}
