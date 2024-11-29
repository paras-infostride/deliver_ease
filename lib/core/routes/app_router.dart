import 'package:deliver_ease/core/routes/redirect_util.dart';
import 'package:deliver_ease/presentation/features/authentication/otp_verify/otp_verify_screen.dart';
import 'package:deliver_ease/presentation/features/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/features/authentication/login/login_screen.dart';
import '../../presentation/features/dashboard/dashboard_screen.dart';
import 'app_router_observer.dart';
import 'app_routes_name.dart';

class AppRouter {
  static final parentNavigatorKey = GlobalKey<NavigatorState>();

  static final routers = GoRouter(
    observers: [
      GoRouterObserver(),
    ],
    redirect: (BuildContext context, GoRouterState state) async {
      return null;
    },
    debugLogDiagnostics: true,
    // navigatorKey: parentNavigatorKey,
    initialLocation: '/dashboard',
    routes: [

      /// Login
      GoRoute(
        path: '/login',
name: AppRoutesName.loginScreen,
        builder: (context, state) => const LoginScreen(),
        redirect: RedirectUtil.redirect,
      ),

      ///OTP Verify
      GoRoute(
        path: '/otp-verify',
        name: AppRoutesName.otpVerifyScreen,
        builder: (context, state) {
          Map<String, dynamic> extra = state.extra as Map<String, dynamic>;
          return  OtpVerifyScreen(
            verificationID: extra['verificationID']
          );
        },
        // redirect: RedirectUtil.redirect,
      ),

      /// Dashboard
      GoRoute(
        path: '/dashboard',
        name: AppRoutesName.dashboardScreen,
        builder: (context, state) => const DashboardScreen(),
        redirect: RedirectUtil.redirect,
      ),

      /// Profile
      GoRoute(
        path: '/profile',
        name: AppRoutesName.profileScreen,
        builder: (context, state)
        {
          Map<String, dynamic> extra = state.extra as Map<String, dynamic>;
          return  ProfileScreen(
            userProfile: extra["userProfile"],
          );
        },
        redirect: RedirectUtil.redirect,
      ),

    ],
  );
}
