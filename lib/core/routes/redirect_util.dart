import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

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

  static Future<String> redirectForAuth(
      BuildContext context, GoRouterState state) async {
    debugPrint("redirect for auth working");
    bool userAuthenticated = true;
    // PreferenceManager.getBool(SharedPreferencesKey.userAuthenticatedId);
    bool userHadReadTheTestInstructions = true;
    // PreferenceManager.getBool(SharedPreferencesKey.userReadTheInstruction);
    bool userCompletedTheTest = true;
    // PreferenceManager.getBool(SharedPreferencesKey.userCompletedTheTest);

    debugPrint("userAuthenticated $userAuthenticated");
    debugPrint(
        "userHadReadTheTestInstructions $userHadReadTheTestInstructions");
    debugPrint("userCompletedTheTestlue $userCompletedTheTest");

    if (userAuthenticated &&
        userHadReadTheTestInstructions &&
        userCompletedTheTest) {
      return "/results";
    } else if (userAuthenticated && userHadReadTheTestInstructions == false) {
      return "/instructions";
    } else if (userAuthenticated) {
      return "/test";
    } else {
      return "/";
    }
  }

  static Future<String?> redirectForResultPage(
      BuildContext context, GoRouterState state) async {
    bool value = true;
    // PreferenceManager.getBool(SharedPreferencesKey.userCompletedTheTest);
    if (value) {
      return "/result";
    } else {
      return "/";
    }
  }
}
