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
    initialLocation: AppRoutes.signInPathScreen.fullPath,
    routes: <RouteBase>[
      GoRoute(
          path: AppRoutes.signInPathScreen.fullPath,
          builder: (context, state) => const SignInScreen()),
      GoRoute(
          path: AppRoutes.signUpPathScreen.fullPath,
          builder: (context, state) => const SignUpScreen()),
      GoRoute(
          path: AppRoutes.forgotPathScreen.fullPath,
          builder: (context, state) => const ForgotScreen()),
      GoRoute(
          path: AppRoutes.homeScreen.fullPath,
          builder: (context, state) => const HomeScreen()),
      GoRoute(
          path: AppRoutes.trucksVansScreen.fullPath,
          builder: (context, state) => const TrucksVansScreen()),
      GoRoute(
          path: AppRoutes.indicatorsScreen.fullPath,
          builder: (context, state) => const IndicatorsScreen()),
      ShellRoute(
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state, Widget child) =>
            MDScaffoldNavbar(child: child),
        routes: [
          GoRoute(
              path: AppRoutes.inventoryScreen.fullPath,
              builder: (context, state) => InventoryScreen(key: state.pageKey)),
          GoRoute(
              path: AppRoutes.movementScreen.fullPath,
              builder: (context, state) => MovementScreen(key: state.pageKey)),
          GoRoute(
              path: AppRoutes.reportsScreen.fullPath,
              builder: (context, state) => ReportsScreen(key: state.pageKey)),
        ],
      ),
    ],
    redirect: (context, state) {
      final authState = BlocProvider.of<AuthBloc>(context, listen: false).state;
      final isAuthenticated =
          authState.auth.name == AuthStatus.authenticated.name;
      final isSignInScreen =
          state.fullPath == AppRoutes.signInPathScreen.fullPath;

      // Go to /sign-in if user is not authenticated
      if (!isAuthenticated) {
        return AppRoutes.signInPathScreen.fullPath;
      }

      // Go to /home if user is authenticated and still in the /sign-in
      if (isAuthenticated && isSignInScreen) {
        return AppRoutes.homeScreen.fullPath;
      }

      // No need to redirect at all
      return null;
    },
    errorPageBuilder: (context, state) => MaterialPage(
      child: ErrorScreen(
        state.error as Exception,
      ),
    ),
  );

  static GoRouter get router => _router;
}
