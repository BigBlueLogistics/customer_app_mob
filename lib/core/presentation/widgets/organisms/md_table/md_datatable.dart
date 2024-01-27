import 'package:flutter/material.dart';

/// A reusable widget [PaginatedDataTable].

extension DataRowExtension on DataRow {
  Widget toContainer({
    required Border border,
    BorderRadiusGeometry? borderRadius,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: border,
        borderRadius: borderRadius,
      ),
      child: this as Widget,
    );
  }
}

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
  const MDDataTableColumns({required this.title, required this.accessorKey});

  final String title;

  final String accessorKey;
}

class MDDataTable extends StatelessWidget {
  const MDDataTable({
    super.key,
    required this.columns,
    required this.dataSource,
    this.rowsPerPage = 10,
  });

  final List<MDDataTableColumns> columns;

  final List<Map<String, dynamic>> dataSource;

  final int rowsPerPage;

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
      headingRowHeight: 35,
      rowsPerPage: rowsPerPage,
      columns: generateColumn(),
      source: generateData(),
    );
  }
}
