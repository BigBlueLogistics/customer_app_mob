import 'dart:math';

import 'package:customer_app_mob/core/presentation/widgets/templates/inventory_template.dart';
import 'package:customer_app_mob/core/utils/shared_prefs.dart';
import 'package:flutter/material.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<StatefulWidget> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  late TextEditingController searchText = TextEditingController();
  late List<Map<String, dynamic>> sortedData = [];
  late int selectedBarIndex = 1;

  @override
  void initState() {
    super.initState();

    debugPrint('init state Inventory');
    debugPrint(SharedPrefs.getApiToken());
    generateData();
  }

  @override
  void dispose() {
    super.dispose();

    searchText.dispose();
  }

  void generateData() {
    debugPrint('generating datazz');

    Future.delayed(const Duration(seconds: 3), () {
      debugPrint('generated datazz');
      setState(() {
        sortedData = List.generate(
          100000,
          (index) => {
            'id': index,
            'title': 'item $index',
            'price': Random().nextInt(100000),
            'title1': 'item $index',
            'title2': 'item $index',
          },
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InventoryTemplate(
      data: sortedData,
      searchText: searchText,
      selectedBarIndex: selectedBarIndex,
    );
  }
}
