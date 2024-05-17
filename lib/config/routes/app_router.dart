import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:customer_app_mob/config/routes/app_routes.dart';
import 'package:customer_app_mob/core/shared/enums/auth_status.dart';
import 'package:customer_app_mob/core/presentation/screens/home.dart';
import 'package:customer_app_mob/core/presentation/screens/movement.dart';
import 'package:customer_app_mob/core/presentation/screens/welcome.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_scaffold_navbar/md_scaffold_navbar.dart';
import 'package:customer_app_mob/core/presentation/screens/error.dart';
import 'package:customer_app_mob/core/presentation/screens/inventory.dart';
import 'package:customer_app_mob/core/presentation/bloc/auth/auth_bloc.dart';
import 'package:customer_app_mob/core/presentation/screens/auth/sign_in.dart';
import 'package:customer_app_mob/core/presentation/screens/auth/sign_up.dart';
import 'package:customer_app_mob/core/presentation/screens/auth/forgot.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: AppRoutes.rootPathScreen,
    routes: [
      GoRoute(
        path: AppRoutes.rootPathScreen,
        builder: (context, state) => const WelcomeScreen(),
        routes: <RouteBase>[
          GoRoute(
              path: AppRoutes.signInPathScreen,
              builder: (context, state) => const SignInScreen()),
          GoRoute(
              path: AppRoutes.signUpPathScreen,
              builder: (context, state) => const SignUpScreen()),
          GoRoute(
              path: AppRoutes.forgotPathScreen,
              builder: (context, state) => const ForgotScreen()),
          StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) =>
                MDScaffoldNavbar(navigationShell: navigationShell),
            branches: [
              StatefulShellBranch(routes: <RouteBase>[
                GoRoute(
                    path: AppRoutes.homeScreen,
                    builder: (context, state) => const HomeScreen()),
              ]),
              StatefulShellBranch(routes: <RouteBase>[
                GoRoute(
                    path: AppRoutes.inventoryScreen,
                    builder: (context, state) => const InventoryScreen()),
              ]),
              StatefulShellBranch(routes: <RouteBase>[
                GoRoute(
                    path: AppRoutes.movementScreen,
                    builder: (context, state) => const MovementScreen()),
              ]),
            ],
          ),
        ],
        redirect: (context, state) {
          // Todo: create a welcome screen and save a cache boolean value if already visited the screen.
          const bool isFromWelcomeScreen = true;
          final authState =
              BlocProvider.of<AuthBloc>(context, listen: false).state;
          final isAuthenticated =
              authState.auth.name == AuthStatus.authenticated.name;
          final isSignInScreen =
              state.fullPath == '/${AppRoutes.signInPathScreen}';
          final isRootScreen = state.fullPath == AppRoutes.rootPathScreen;

          if (isFromWelcomeScreen) {
            // Go to /sign-in if user is not authenticated
            if (!isAuthenticated) {
              return '/${AppRoutes.signInPathScreen}';
            }

            // Go to /home if user is authenticated and still in the /sign-in
            if (isAuthenticated && isRootScreen ||
                isAuthenticated && isSignInScreen) {
              return '/${AppRoutes.homeScreen}';
            }
          }

          // No need to redirect at all
          return null;
        },
      )
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      child: ErrorScreen(
        state.error as Exception,
      ),
    ),
  );

  static GoRouter get router => _router;
}
