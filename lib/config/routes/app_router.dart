import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app_mob/core/presentation/screens/inventory.dart';
import 'package:customer_app_mob/core/dependencies.dart';
import 'package:customer_app_mob/config/routes/app_routes.dart';
import 'package:customer_app_mob/core/presentation/bloc/auth/auth_bloc.dart';
import 'package:customer_app_mob/core/presentation/screens/auth/sign_in.dart';
import 'package:customer_app_mob/core/presentation/screens/auth/sign_up.dart';
import 'package:customer_app_mob/core/presentation/screens/auth/forgot.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.inventoryScreen,
    routes: [
      GoRoute(
        path: AppRoutes.signInPathScreen,
        builder: (context, state) => BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(getIt()),
          child: const SignInScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.signUpPathScreen,
        builder: (context, state) => BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(getIt()),
          child: const SignUpScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.forgotPathScreen,
        builder: (context, state) => BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(getIt()),
          child: const ForgotScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.inventoryScreen,
        builder: (context, state) => BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(getIt()),
          child: const Inventory(),
        ),
      )
    ],
  );

  static GoRouter get router => _router;
}
