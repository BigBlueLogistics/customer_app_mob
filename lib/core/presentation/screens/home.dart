import 'package:customer_app_mob/config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:customer_app_mob/core/presentation/widgets/templates/home/home_template.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController _searchText = TextEditingController();
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
      'route': null,
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
      'route': null,
      'icon': const Icon(Icons.local_shipping_rounded,
          color: Color.fromARGB(255, 22, 121, 171))
    },
  ];

  @override
  Widget build(BuildContext context) {
    return HomeTemplate(
      username: 'Roelan',
      searchText: _searchText,
      menuList: menuList,
    );
  }
}
