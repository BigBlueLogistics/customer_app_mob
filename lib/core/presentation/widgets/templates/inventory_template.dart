import 'package:flutter/material.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_scaffold/md_scaffold.dart';
import 'package:customer_app_mob/core/presentation/widgets/molecules/md_search_more/md_search_more.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_table/md_datatable.dart';

class InventoryTemplate extends StatelessWidget {
  const InventoryTemplate({
    super.key,
    required this.data,
    required this.searchText,
    this.selectedBarIndex = 0,
  });

  final List<Map<String, dynamic>> data;

  final TextEditingController searchText;

  final int selectedBarIndex;

  @override
  Widget build(BuildContext context) {
    return MDScaffold(
      appBarTitle: 'Inventory',
      selectedBarIndex: selectedBarIndex,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MDSearchMore(searchText: searchText),
          Text(
            'Material Details',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.6,
                ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(16.0),
            child: MDDataTable(
              rowsPerPage: 5,
              columns: const <MDDataTableColumns>[
                MDDataTableColumns(title: 'WAREHOUSE', accessorKey: 'id'),
                MDDataTableColumns(
                    title: 'MATERIAL CODE', accessorKey: 'title'),
                MDDataTableColumns(title: 'DESCRIPTION', accessorKey: 'price'),
                MDDataTableColumns(
                    title: 'FIXED WEIGHT', accessorKey: 'title1'),
                MDDataTableColumns(
                    title: 'AVAILABLE STOCKS', accessorKey: 'title2'),
              ],
              dataSource: data,
            ),
          ),
        ],
      ),
    );
  }
}
