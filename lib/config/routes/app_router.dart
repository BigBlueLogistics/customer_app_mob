import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:customer_app_mob/config/routes/app_routes.dart';
import 'package:customer_app_mob/core/shared/enums/auth_status.dart';
import 'package:customer_app_mob/core/presentation/bloc/auth/auth_bloc.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_scaffold_navbar/md_scaffold_navbar.dart';
import 'package:customer_app_mob/core/presentation/screens/home.dart';
import 'package:customer_app_mob/core/presentation/screens/welcome.dart';
import 'package:customer_app_mob/core/presentation/screens/error.dart';
import 'package:customer_app_mob/core/presentation/screens/movement/movement.dart';
import 'package:customer_app_mob/core/presentation/screens/inventory/inventory.dart';
import 'package:customer_app_mob/core/presentation/screens/reports/reports.dart';
import 'package:customer_app_mob/core/presentation/screens/auth/sign_in.dart';
import 'package:customer_app_mob/core/presentation/screens/trucks_vans/trucks_vans.dart';
import 'package:customer_app_mob/core/presentation/screens/indicators/indicators.dart';
import 'package:customer_app_mob/core/presentation/screens/auth/sign_up.dart';
import 'package:customer_app_mob/core/presentation/screens/auth/forgot.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'rootNavKey');

class AppRouter {
  static final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    initialLocation: AppRoutes.rootPathScreen,
    routes: [
      GoRoute(
        path: AppRoutes.rootPathScreen,
        builder: (context, state) => const WelcomeScreen(),
        routes: <RouteBase>[
          GoRoute(
              path: AppRoutes.signInPathScreen.path,
              builder: (context, state) => const SignInScreen()),
          GoRoute(
              path: AppRoutes.signUpPathScreen.path,
              builder: (context, state) => const SignUpScreen()),
          GoRoute(
              path: AppRoutes.forgotPathScreen.path,
              builder: (context, state) => const ForgotScreen()),
          GoRoute(
              path: AppRoutes.homeScreen.path,
              builder: (context, state) => const HomeScreen()),
          GoRoute(
              path: AppRoutes.trucksVansScreen.path,
              builder: (context, state) => const TrucksVansScreen()),
          GoRoute(
              path: AppRoutes.indicatorsScreen.path,
              builder: (context, state) => const IndicatorsScreen()),
          ShellRoute(
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state, Widget child) =>
                MDScaffoldNavbar(child: child),
            routes: [
              GoRoute(
                  path: AppRoutes.inventoryScreen.path,
                  builder: (context, state) =>
                      InventoryScreen(key: state.pageKey)),
              GoRoute(
                  path: AppRoutes.movementScreen.path,
                  builder: (context, state) =>
                      MovementScreen(key: state.pageKey)),
              GoRoute(
                  path: AppRoutes.reportsScreen.path,
                  builder: (context, state) =>
                      ReportsScreen(key: state.pageKey)),
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
              state.fullPath == AppRoutes.signInPathScreen.fullPath;
          final isRootScreen = state.fullPath == AppRoutes.rootPathScreen;

          if (isFromWelcomeScreen) {
            // Go to /sign-in if user is not authenticated
            if (!isAuthenticated) {
              return AppRoutes.signInPathScreen.fullPath;
            }

            // Go to /home if user is authenticated and still in the /sign-in
            if (isAuthenticated && isRootScreen ||
                isAuthenticated && isSignInScreen) {
              return AppRoutes.homeScreen.fullPath;
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
