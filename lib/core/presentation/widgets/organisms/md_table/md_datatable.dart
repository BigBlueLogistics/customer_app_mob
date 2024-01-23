import 'package:flutter/material.dart';

/// A reusable widget [PaginatedDataTable].

class _DataSource extends DataTableSource {
  late List<Map<String, dynamic>> data;

  late List<String> rowsKey;

  _DataSource({required this.data, required this.rowsKey});

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
  int get rowCount => data.length;

  @override
  DataRow? getRow(int index) {
    final cells = List<DataCell>.generate(
      rowsKey.length,
      (rowsIndex) => cellFor(data[index][rowsKey[rowsIndex]]),
    );
    return DataRow(
      cells: cells,
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class MDDataTableColumns {
  final String title;
  final String accessorKey;

  const MDDataTableColumns({required this.title, required this.accessorKey});
}

class MDDataTable extends StatelessWidget {
  final List<MDDataTableColumns> columns;

  final List<Map<String, dynamic>> dataSource;

  final int rowsPerPage;

  const MDDataTable({
    super.key,
    required this.columns,
    required this.dataSource,
    this.rowsPerPage = 10,
  });

  List<DataColumn> generateColumn() {
    return columns
        .map((e) => DataColumn(
              label: Text(e.title),
            ))
        .toList();
  }

  List<String> generateRows() {
    return columns.map((e) => e.accessorKey).toList();
  }

  DataTableSource generateData() {
    return _DataSource(data: dataSource, rowsKey: generateRows());
  }

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      rowsPerPage: rowsPerPage,
      columns: generateColumn(),
      source: generateData(),
    );
  }
}
