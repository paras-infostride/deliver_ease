import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/shared_prefs.dart';


class RedirectUtil {
  static Future<String?> redirectForTestInstruction(
      BuildContext context, GoRouterState state) async {
    bool userHadReadTheTestInstructions = true;
    // PreferenceManager.getBool(SharedPreferencesKey.userReadTheInstruction);
    bool userAuthenticated = true;
    // PreferenceManager.getBool(SharedPreferencesKey.userAuthenticatedId);
    if (userHadReadTheTestInstructions && userAuthenticated) {
      return "/test";
    } else if (userAuthenticated) {
      return null;
    } else {
      return "/";
    }
  }

  static Future<String?> forTestPage(
      BuildContext context, GoRouterState state) async {
    bool userAuthenticated = true;
    // PreferenceManager.getBool(SharedPreferencesKey.userAuthenticatedId);

    if (userAuthenticated) {
      return null;
    } else {
      return "/";
    }
  }

  static Future<String?> redirect(
      BuildContext context, GoRouterState state) async {

    debugPrint("redirect for auth working");
    SharedPreferences sharedPreferences =  await SharedPreferences.getInstance();

    bool userAuthenticated = sharedPreferences.getBool(SharedPreferencesKey.isLogin) ?? false;
    // bool isOTPVerified = sharedPreferences.getBool(SharedPreferencesKey.isOTPVerified) ?? false;
    debugPrint("userAuthenticated $userAuthenticated");

    if(userAuthenticated == false )
      {
        return '/login';
      }
    else
      {
        return null;
      }
  }


}
