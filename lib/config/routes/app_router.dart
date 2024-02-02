import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        builder: (context, state) => const Inventory(),
      )
    ],
    redirect: (context, state) {
      final signedIn =
          BlocProvider.of<AuthBloc>(context).state is AuthSuccessState;
      final signingIn =
          state.matchedLocation.contains(AppRoutes.signInPathScreen);

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
    errorPageBuilder: (context, state) => const MaterialPage(
      child: Scaffold(
        body: Center(child: Text('Error page')),
      ),
    ),
  );

  static GoRouter get router => _router;
}
