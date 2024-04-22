import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:customer_app_mob/core/presentation/screens/error.dart';
import 'package:customer_app_mob/core/shared/enums/auth_status.dart';
import 'package:customer_app_mob/core/presentation/screens/inventory.dart';
import 'package:customer_app_mob/config/routes/app_routes.dart';
import 'package:customer_app_mob/core/presentation/bloc/auth/auth_bloc.dart';
import 'package:customer_app_mob/core/presentation/screens/auth/sign_in.dart';
import 'package:customer_app_mob/core/presentation/screens/auth/sign_up.dart';
import 'package:customer_app_mob/core/presentation/screens/auth/forgot.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.signInPathScreen,
    routes: [
      GoRoute(
        path: AppRoutes.signInPathScreen,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AppRoutes.signUpPathScreen,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPathScreen,
        builder: (context, state) => const ForgotScreen(),
      ),
      GoRoute(
        path: AppRoutes.inventoryScreen,
        builder: (context, state) => const InventoryScreen(),
      )
    ],
    redirect: (context, state) {
      final authState = BlocProvider.of<AuthBloc>(context, listen: false).state;
      final signedIn = authState.auth.name == AuthStatus.authenticated.name;
      final signingIn =
          state.matchedLocation.contains(AppRoutes.signInPathScreen);

      debugPrint('init redirect route');

      // Go to /sign-in if user is not authenticated
      if (!signedIn && signingIn) {
        return AppRoutes.signInPathScreen;
      }

      // Go to /home if user is authenticated and still in the /sign-in
      if (signedIn && signingIn) {
        return AppRoutes.inventoryScreen;
      }

      // No need to redirect at all
      return null;
    },
    errorPageBuilder: (context, state) => MaterialPage(
      child: ErrorScreen(state.error as Exception),
    ),
  );

  static GoRouter get router => _router;
}
