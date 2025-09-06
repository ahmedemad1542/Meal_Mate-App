import 'package:permission_handler/permission_handler.dart';

class AppPermissions {
  
  static Future<void> requestEssentialPermissions() async {
    await [
      Permission.camera,                    // الكاميرا
      Permission.photos,                    // معرض الصور (iOS)
      Permission.storage,                   // التخزين (Android)
      Permission.ignoreBatteryOptimizations // تعطيل تحسين البطارية
    ].request();
  }

  /// طلب صلاحية الكاميرا منفردة
  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  /// طلب صلاحية الوصول للمعرض
  static Future<bool> requestPhotosPermission() async {
    final status = await Permission.photos.request();
    return status.isGranted;
  }

  /// طلب صلاحية التخزين
  static Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  /// طلب صلاحية تعطيل تحسين البطارية
  static Future<bool> requestIgnoreBatteryPermission() async {
    final status = await Permission.ignoreBatteryOptimizations.request();
    return status.isGranted;
  }
}
