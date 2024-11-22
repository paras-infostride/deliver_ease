import 'package:deliver_ease/core/routes/redirect_util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/features/authentication/login_screen.dart';
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
    navigatorKey: parentNavigatorKey,
    initialLocation: '/',
    routes: [
      ///RouteLanding Page Routes
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: LoginScreen(),
        ),
        // redirect: RedirectUtil.redirectForAuth,
      ),

    ],
  );
}
