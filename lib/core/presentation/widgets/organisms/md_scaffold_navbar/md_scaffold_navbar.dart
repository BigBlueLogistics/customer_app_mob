import 'package:customer_app_mob/config/routes/app_router.dart';
import 'package:customer_app_mob/config/routes/app_routes.dart';
import 'package:customer_app_mob/core/utils/log.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class MDScaffoldNavbar extends StatelessWidget {
  /// Constructs an [MDScaffoldNavbar].
  const MDScaffoldNavbar({
    required this.child,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('MDScaffoldNavbar'));

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: true,
        selectedLabelStyle:
            const TextStyle(fontSize: 13.0, fontWeight: FontWeight.w500),
        unselectedLabelStyle:
            const TextStyle(fontSize: 13.0, fontWeight: FontWeight.w500),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2_rounded), label: 'Inventory'),
          BottomNavigationBarItem(
              icon: Icon(Icons.multiline_chart_rounded), label: 'Movement'),
          BottomNavigationBarItem(
              icon: Icon(Icons.summarize_rounded), label: 'Reports'),
        ],
        currentIndex: _onTapCurrentIndex(context),
        onTap: (int index) => _onTap(index, context),
      ),
    );
  }

  /// Navigate to the current location of the branch at the provided index when
  /// tapping an item in the BottomNavigationBar.
  void _onTap(int index, BuildContext context) {
    switch (index) {
      case 0:
        AppRouter.router.go(AppRoutes.homeScreen.fullPath);
        break;
      case 1:
        AppRouter.router.go(AppRoutes.inventoryScreen.fullPath);
        break;
      case 2:
        AppRouter.router.go(AppRoutes.movementScreen.fullPath);
        break;
      case 3:
        AppRouter.router.go(AppRoutes.reportsScreen.fullPath);
        break;
      default:
    }
  }

  int _onTapCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;

    if (location == AppRoutes.inventoryScreen.fullPath) return 1;
    if (location == AppRoutes.movementScreen.fullPath) return 2;
    if (location == AppRoutes.reportsScreen.fullPath) return 3;

    // Default to HomeScreen
    return 0;
  }
}
