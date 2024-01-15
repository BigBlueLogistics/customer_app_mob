import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app_mob/config/routes/app_router.dart';
import 'package:customer_app_mob/core/presentation/bloc/auth/auth_bloc.dart';
import 'package:customer_app_mob/core/dependencies.dart';
import 'package:customer_app_mob/config/theme/light_theme.dart';
import 'package:customer_app_mob/config/theme/dark_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(getIt()),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        darkTheme: darkMode,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
