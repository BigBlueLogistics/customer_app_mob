import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:customer_app_mob/config/routes/app_routes.dart';
import 'package:customer_app_mob/core/presentation/screens/auth/sign_in.dart';
import 'package:customer_app_mob/core/presentation/screens/auth/sign_up.dart';
import 'package:customer_app_mob/core/presentation/screens/auth/forgot.dart';

class AppRouter {
  static final GoRouter _router =
      GoRouter(initialLocation: AppRoutes.signInPathScreen, routes: [
    GoRoute(
      path: AppRoutes.signInPathScreen,
      pageBuilder: (context, state) {
        return const MaterialPage(child: SignInScreen());
      },
    ),
    GoRoute(
      path: AppRoutes.signUpPathScreen,
      pageBuilder: (context, state) {
        return const MaterialPage(child: SignUpScreen());
      },
    ),
    GoRoute(
      path: AppRoutes.forgotPathScreen,
      pageBuilder: (context, state) {
        return const MaterialPage(child: ForgotScreen());
      },
    )
  ]);

  static GoRouter get router => _router;
}
