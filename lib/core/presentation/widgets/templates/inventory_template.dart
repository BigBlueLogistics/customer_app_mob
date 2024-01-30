import 'package:flutter/material.dart';
import 'package:customer_app_mob/core/presentation/widgets/molecules/md_search/md_search.dart';
import 'package:customer_app_mob/core/presentation/widgets/molecules/md_filter/md_filter.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_scaffold/md_scaffold.dart';
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
    final mediaHeight = MediaQuery.of(context).size.height;

    return MDScaffold(
      appBarTitle: 'Inventory',
      selectedBarIndex: selectedBarIndex,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MDFilter(searchText: searchText),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: mediaHeight * 0.05, bottom: 5.0),
                      child: MDSearch(searchText: searchText),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
                      child: Text(
                        'Material Details',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.6,
                                ),
                      ),
                    ),
                    MDDataTable(
                      rowsPerPage: 5,
                      dataSource: data,
                      columns: const <MDDataTableColumns>[
                        MDDataTableColumns(
                            title: 'WAREHOUSE', accessorKey: 'id'),
                        MDDataTableColumns(
                            title: 'MATERIAL CODE', accessorKey: 'title'),
                        MDDataTableColumns(
                            title: 'DESCRIPTION', accessorKey: 'price'),
                        MDDataTableColumns(
                            title: 'FIXED WEIGHT', accessorKey: 'title1'),
                        MDDataTableColumns(
                            title: 'AVAILABLE STOCKS', accessorKey: 'title2'),
                      ],
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
