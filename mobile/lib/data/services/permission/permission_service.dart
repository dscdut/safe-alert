abstract class PermissionSesrvice {
  Future requestPhotosPermission();
  Future<void> handlePhotosPermission();
  Future requestCameraPermission();
  Future<bool> handleCameraPermission();
}
