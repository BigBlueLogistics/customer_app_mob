import 'package:flutter/material.dart';

class _RoutePath {
  const _RoutePath({
    required this.fullPath,
    required this.title,
    this.isPrivateRoute = false,
    this.icon,
  });

  final String fullPath;
  final String title;
  final bool isPrivateRoute;
  final Icon? icon;
}

final class AppRoutes {
  static const rootPathScreen = '/';
  static const signInPathScreen =
      _RoutePath(title: 'Sign-in', fullPath: '/sign-in');
  static const signUpPathScreen =
      _RoutePath(title: 'Sign-up', fullPath: '/sign-up');
  static const forgotPathScreen =
      _RoutePath(title: 'Forgot password', fullPath: '/forgot');
  static const homeScreen =
      _RoutePath(title: 'Home', fullPath: '/home', isPrivateRoute: true);
  static const inventoryScreen = _RoutePath(
    title: 'Inventory',
    fullPath: '/inventory',
    isPrivateRoute: true,
    icon: Icon(Icons.inventory_2_rounded,
        color: Color.fromARGB(255, 22, 121, 171)),
  );
  static const movementScreen = _RoutePath(
    title: 'Movement',
    fullPath: '/movement',
    isPrivateRoute: true,
    icon: Icon(Icons.trending_up_rounded,
        color: Color.fromARGB(255, 22, 121, 171)),
  );
  static const reportsScreen = _RoutePath(
    title: 'Reports',
    fullPath: '/reports',
    isPrivateRoute: true,
    icon:
        Icon(Icons.summarize_rounded, color: Color.fromARGB(255, 22, 121, 171)),
  );
  static const trucksVansScreen = _RoutePath(
    title: 'Trucks & Vans',
    fullPath: '/trucks-vans',
    isPrivateRoute: true,
    icon:
        Icon(Icons.move_down_rounded, color: Color.fromARGB(255, 22, 121, 171)),
  );
  static const indicatorsScreen = _RoutePath(
    title: 'Indicators',
    fullPath: '/indicators',
    isPrivateRoute: true,
    icon: Icon(Icons.local_shipping_rounded,
        color: Color.fromARGB(255, 22, 121, 171)),
  );

  // ignore: library_private_types_in_public_api
  static final Map<String, _RoutePath> properties = {
    'signInPathScreen': signInPathScreen,
    'signUpPathScreen': signUpPathScreen,
    'forgotPathScreen': forgotPathScreen,
    'homeScreen': homeScreen,
    'inventoryScreen': inventoryScreen,
    'movementScreen': movementScreen,
    'reportsScreen': reportsScreen,
    'trucksVansScreen': trucksVansScreen,
    'indicatorsScreen': indicatorsScreen,
  };
}
