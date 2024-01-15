import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app_mob/core/dependencies.dart';
import 'package:customer_app_mob/config/routes/app_routes.dart';
import 'package:customer_app_mob/core/presentation/bloc/auth/auth_bloc.dart';
import 'package:customer_app_mob/core/presentation/screens/auth/sign_in.dart';
import 'package:customer_app_mob/core/presentation/screens/auth/sign_up.dart';
import 'package:customer_app_mob/core/presentation/screens/auth/forgot.dart';

class AppRouter {
  static final GoRouter _router =
      GoRouter(initialLocation: AppRoutes.signInPathScreen, routes: [
    GoRoute(
      path: AppRoutes.signInPathScreen,
      builder: (context, state) => BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(getIt()),
        child: const SignInScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.signUpPathScreen,
      pageBuilder: (context, state) {
        return const MaterialPage(child: SignUpScreen());
      },
    ),
    GoRoute(
      path: AppRoutes.forgotPathScreen,
      builder: (context, state) => BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(getIt()),
        child: const ForgotScreen(),
      ),
    )
  ]);

  static GoRouter get router => _router;
}
