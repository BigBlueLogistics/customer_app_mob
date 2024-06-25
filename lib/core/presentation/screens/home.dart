import 'package:customer_app_mob/config/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:customer_app_mob/config/routes/app_routes.dart';
import 'package:customer_app_mob/core/presentation/widgets/templates/home/home_template.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchText = TextEditingController();

  bool _isMenuTapped = false;
  String _currentRouteName = '';

  final List<Map<String, dynamic>> menuList = [
    {
      'title': AppRoutes.inventoryScreen.title,
      'route': AppRoutes.inventoryScreen.fullPath,
      'icon': AppRoutes.inventoryScreen.icon
    },
    {
      'title': AppRoutes.movementScreen.title,
      'route': AppRoutes.movementScreen.fullPath,
      'icon': AppRoutes.movementScreen.icon
    },
    {
      'title': AppRoutes.reportsScreen.title,
      'route': AppRoutes.reportsScreen.fullPath,
      'icon': AppRoutes.reportsScreen.icon
    },
    {
      'title': AppRoutes.indicatorsScreen.title,
      'route': AppRoutes.indicatorsScreen.fullPath,
      'icon': AppRoutes.indicatorsScreen.icon
    },
    {
      'title': AppRoutes.trucksVansScreen.title,
      'route': AppRoutes.trucksVansScreen.fullPath,
      'icon': AppRoutes.trucksVansScreen.icon
    },
  ];

  void onTapMenu(String route) {
    setState(() {
      _isMenuTapped = !_isMenuTapped;
      _currentRouteName = route;
    });

    if (route.isNotEmpty) {
      AppRouter.router.go(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return HomeTemplate(
      username: 'Roelan',
      searchText: _searchText,
      menuList: menuList,
      isMenuTapped: _isMenuTapped,
      currentRouteName: _currentRouteName,
      onTapMenu: onTapMenu,
    );
  }
}
