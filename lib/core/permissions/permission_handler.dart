import 'package:flutter/material.dart';
import 'package:meal_mate/core/permissions/app_permissions.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> requestPermissionsWithDialog(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  bool? permissionsAsked = prefs.getBool('permissionsAsked');

  // إذا لم نطلب الصلاحيات من قبل
  if (permissionsAsked != true) {
    bool userAccepted = false;

    // نظهر Dialog قبل الطلب
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Permissions Required"),
        content: const Text(
          "Meal Mate needs access to your camera, storage, and gallery to function properly. "
          "Please allow these permissions."
        ),
        actions: [
          TextButton(
            onPressed: () {
              userAccepted = false;
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              userAccepted = true;
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );

    if (userAccepted) {
      // اطلب الصلاحيات الأساسية
      await AppPermissions.requestEssentialPermissions();
      // خزّن في SharedPreferences أننا طلبنا الصلاحيات
      await prefs.setBool('permissionsAsked', true);
    }
  }
}
