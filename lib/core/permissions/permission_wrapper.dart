import 'package:flutter/material.dart';
import 'package:meal_mate/core/permissions/permission_handler.dart';
import 'package:meal_mate/features/home_screen/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meal_mate/core/permissions/app_permissions.dart';
import 'package:meal_mate/features/home_screen/home_screen.dart';

class PermissionsWrapper extends StatefulWidget {
  const PermissionsWrapper({super.key});

  @override
  State<PermissionsWrapper> createState() => _PermissionsWrapperState();
}

class _PermissionsWrapperState extends State<PermissionsWrapper> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _requestPermissions();
    });
  }

  Future<void> _requestPermissions() async {
    final prefs = await SharedPreferences.getInstance();
    bool? permissionsAsked = prefs.getBool('permissionsAsked');

    if (permissionsAsked != true) {
      bool userAccepted = false;

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
        await AppPermissions.requestEssentialPermissions();
        await prefs.setBool('permissionsAsked', true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
