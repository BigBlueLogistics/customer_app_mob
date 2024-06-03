class _RoutePath {
  const _RoutePath({required this.path, required this.fullPath});

  final String path;
  final String fullPath;
}

final class AppRoutes {
  static const rootPathScreen = '/';
  static const signInPathScreen =
      _RoutePath(path: 'sign-in', fullPath: '/sign-in');
  static const signUpPathScreen =
      _RoutePath(path: 'sign-up', fullPath: '/sign-up');
  static const forgotPathScreen =
      _RoutePath(path: 'forgot', fullPath: '/forgot');
  static const inventoryScreen =
      _RoutePath(path: 'inventory', fullPath: '/inventory');
  static const movementScreen =
      _RoutePath(path: 'movement', fullPath: '/movement');
  static const homeScreen = _RoutePath(path: 'home', fullPath: '/home');
  static const reportsScreen =
      _RoutePath(path: 'reports', fullPath: '/reports');
  static const trucksVansScreen =
      _RoutePath(path: 'trucks-vans', fullPath: '/trucks-vans');
}
