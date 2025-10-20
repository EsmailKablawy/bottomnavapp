// ignore: file_names
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> saveFcmTokn(String fcmTokn) async {
    try {
      return await _prefs?.setString('FCM', fcmTokn) ?? false;
    } catch (e) {
      return false;
    }
  }

  static String getFcmTokn() {
    try {
      return _prefs?.getString('FCM') ?? "";
    } catch (e) {
      return "";
    }
  }

  static clearShared() {
    _prefs?.clear();
  }
}
