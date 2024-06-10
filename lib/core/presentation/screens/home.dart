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
      'title': 'Inventory',
      'route': AppRoutes.inventoryScreen.fullPath,
      'icon': const Icon(Icons.inventory_2_rounded,
          color: Color.fromARGB(255, 22, 121, 171))
    },
    {
      'title': 'Movements',
      'route': AppRoutes.movementScreen.fullPath,
      'icon': const Icon(Icons.trending_up_rounded,
          color: Color.fromARGB(255, 22, 121, 171))
    },
    {
      'title': 'Reports',
      'route': AppRoutes.reportsScreen.fullPath,
      'icon': const Icon(Icons.summarize_rounded,
          color: Color.fromARGB(255, 22, 121, 171))
    },
    {
      'title': 'Indicators',
      'route': null,
      'icon': const Icon(Icons.move_down_rounded,
          color: Color.fromARGB(255, 22, 121, 171))
    },
    {
      'title': 'Trucks & Vans',
      'route': AppRoutes.trucksVansScreen.fullPath,
      'icon': const Icon(Icons.local_shipping_rounded,
          color: Color.fromARGB(255, 22, 121, 171))
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
