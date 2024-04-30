import 'package:flutter/material.dart';
import 'package:customer_app_mob/core/presentation/widgets/templates/inventory_template.dart';
import 'package:customer_app_mob/core/usecases/inventory/get_inventory.dart';
import 'package:customer_app_mob/core/dependencies.dart';

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

    generateData();
  }

  @override
  void dispose() {
    super.dispose();

    searchText.dispose();
  }

  void generateData() async {
    final data = await getIt<InventoryUseCase>()
        .call(InventoryParams(customerCode: 'FGRETAIL', warehouse: 'BB05'));

    final resp = data.resp!.data!;

    setState(() {
      sortedData = resp;
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
