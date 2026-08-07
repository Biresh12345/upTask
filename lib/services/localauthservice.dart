import 'dart:io';

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class AppSingleton {
  static final AppSingleton _instance = AppSingleton._internal();

  static AppSingleton get instance => _instance;

  AppSingleton._internal();

  bool isAuthenticated = false;
}

abstract class Localauthservice {
  static final LocalAuthentication localAuth = LocalAuthentication();
  static bool isAuthenticated = false;

  static Future<void> authenticate() async {
    bool isAuth = false;

    try {
      isAuth = await localAuth.authenticate(
          localizedReason: 'Please authenticate to access the app',
          biometricOnly: false);

      AppSingleton.instance.isAuthenticated = isAuth;

      if (!isAuth) {
        exit(0);
      }
    } on PlatformException catch (e) {
      if (Platform.isIOS && e.code == 'userCanceled') {
        exit(0);
      }
    }
  }
}
