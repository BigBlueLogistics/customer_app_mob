import 'dart:math';

import 'package:flutter/material.dart';
import 'package:customer_app_mob/core/presentation/widgets/atoms/md_button/md_filled.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_table/md_datatable.dart';

/// Flutter code sample for [PaginatedDataTable].

class MyDataSource extends DataTableSource {
  late List<Map<String, dynamic>> sortedData = List.generate(
      100000,
      (index) => {
            'id': index,
            'title': 'item $index',
            'price': Random().nextInt(100000),
            'title1': 'item $index',
            'title2': 'item $index',
          });

  static DataCell cellFor(Object data) {
    String value;
    if (data is DateTime) {
      value =
          '${data.year}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}';
    } else {
      value = data.toString();
    }
    return DataCell(Text(value));
  }

  @override
  int get rowCount => sortedData.length;

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: <DataCell>[
        cellFor(sortedData[index]['id']),
        cellFor(sortedData[index]['title']),
        cellFor(sortedData[index]['price']),
        cellFor(sortedData[index]['title1']),
        cellFor(sortedData[index]['title2']),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class InventoryApp extends StatefulWidget {
  const InventoryApp({super.key});

  @override
  State<StatefulWidget> createState() => _InventoryApp();
}

class _InventoryApp extends State<InventoryApp> {
  late List<Map<String, dynamic>> sortedData = [];

  @override
  void initState() {
    super.initState();

    generateData();
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
    return Flex(
      direction: Axis.vertical,
      children: [
        MDFilledButton(onPressed: () => {generateData()}, text: 'Reload'),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(16.0),
          child: MDDataTable(
            rowsPerPage: 5,
            columns: const <MDDataTableColumns>[
              MDDataTableColumns(title: 'Id', accessorKey: 'id'),
              MDDataTableColumns(title: 'Title 1', accessorKey: 'title'),
              MDDataTableColumns(title: 'Title 2', accessorKey: 'price'),
              MDDataTableColumns(title: 'Title 3', accessorKey: 'title1'),
              MDDataTableColumns(title: 'Title 4', accessorKey: 'title2'),
            ],
            dataSource: sortedData,
          ),
        ),
      ],
    );
  }
}

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  final MyDataSource dataSource = MyDataSource();

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      rowsPerPage: 15,
      columns: const <DataColumn>[
        DataColumn(
          label: Text('Id'),
        ),
        DataColumn(
          label: Text('Title'),
        ),
        DataColumn(
          label: Text('Price'),
        ),
        DataColumn(
          label: Text('Title 1'),
        ),
        DataColumn(
          label: Text('Title 3'),
        ),
      ],
      source: dataSource,
    );
  }
}
