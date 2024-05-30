import 'package:customer_app_mob/core/presentation/widgets/organisms/md_datatable/md_datatable.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_filtering/button_segmented.dart';

final List<SegmentedValueMap> reportTypeList = [
  const SegmentedValueMap(value: 'wh-snapshot', label: 'WH Snapshot'),
  const SegmentedValueMap(value: 'aging-report', label: 'Aging Report'),
];

final List<SegmentedValueMap> _groupBySnapshotList = [
  const SegmentedValueMap(value: 'material', label: 'Material'),
  const SegmentedValueMap(value: 'batch', label: 'Batch'),
  const SegmentedValueMap(value: 'expiry', label: 'Expiry'),
];
final List<SegmentedValueMap> _groupByAgingList = [
  const SegmentedValueMap(value: 'expiration', label: 'Expiration'),
  const SegmentedValueMap(value: 'receiving', label: 'Receiving Date'),
];

List<SegmentedValueMap> getGroupByOptions(SegmentedValue value) {
  if (reportTypeList[0] == value) {
    return _groupBySnapshotList;
  }

  if (reportTypeList[1] == value) {
    return _groupByAgingList;
  }

  return [const SegmentedValueMap()];
}

final _commonHeaders = [
  const MDDataTableColumns(title: 'Material Code', accessorKey: 'materialCode'),
  const MDDataTableColumns(title: 'Description', accessorKey: 'description'),
  const MDDataTableColumns(title: 'Fixed Weight', accessorKey: 'fixedWt'),
];
List<MDDataTableColumns> columnSnapshot(SegmentedValueMap? snapshotGroupBy) {
  final headers = [
    const MDDataTableColumns(
        title: 'Available Stocks', accessorKey: 'availableQty'),
    const MDDataTableColumns(
        title: 'Allocated Stocks', accessorKey: 'allocatedQty'),
    const MDDataTableColumns(
        title: 'Restricted Stocks', accessorKey: 'restrictedQty'),
    const MDDataTableColumns(title: 'Total Stocks', accessorKey: 'totalQty'),
  ];

  // Group by index[0] = Material.
  if (snapshotGroupBy?.value == _groupBySnapshotList[0].value) {
    return [..._commonHeaders, ...headers];
  }

  // Group by index[1] = Batch.
  if (snapshotGroupBy?.value == _groupBySnapshotList[1].value) {
    return [
      ..._commonHeaders,
      const MDDataTableColumns(title: 'Batch / Lot', accessorKey: 'batch'),
      const MDDataTableColumns(title: 'Expiry date', accessorKey: 'expiry'),
      ...headers
    ];
  }

  // Group by index[2] = Expiry.
  if (snapshotGroupBy?.value == _groupBySnapshotList[2].value) {
    return [
      ..._commonHeaders,
      const MDDataTableColumns(title: 'Expiry date', accessorKey: 'expiry'),
      ...headers
    ];
  }

  // Empty column
  return [
    // const MDDataTableColumns(title: 'empty', accessorKey: 'empty'),
  ];
}

List<MDDataTableColumns> columnAging(SegmentedValueMap? agingGroupBy) {
  // Group by index[0] = Receiving.
  if (agingGroupBy?.value == _groupByAgingList[0].value) {
    return [
      ..._commonHeaders,
      const MDDataTableColumns(title: '> 120 days', accessorKey: 'qty_exp_120'),
      const MDDataTableColumns(title: '> 60 days', accessorKey: 'qty_exp_60'),
      const MDDataTableColumns(title: '> 30 days', accessorKey: 'qty_exp_30'),
      const MDDataTableColumns(title: '> 15 days', accessorKey: 'qty_exp_15'),
      const MDDataTableColumns(title: '> 1 day', accessorKey: 'qty_exp_0'),
      const MDDataTableColumns(
          title: 'Receipts Now', accessorKey: 'qty_expired'),
      const MDDataTableColumns(
          title: 'Total Quantity', accessorKey: 'totalQty'),
    ];
  }

  // Group by index[1] = Expiration.
  if (agingGroupBy?.value == _groupByAgingList[1].value) {
    return [
      ..._commonHeaders,
      const MDDataTableColumns(title: '> 120 days', accessorKey: 'qty_exp_120'),
      const MDDataTableColumns(title: '> 60 days', accessorKey: 'qty_exp_60'),
      const MDDataTableColumns(title: '> 30 days', accessorKey: 'qty_exp_30'),
      const MDDataTableColumns(title: '> 15 days', accessorKey: 'qty_exp_15'),
      const MDDataTableColumns(title: '< 15 days', accessorKey: 'qty_exp_0'),
      const MDDataTableColumns(
          title: 'Expired Producs', accessorKey: 'qty_expired'),
      const MDDataTableColumns(
          title: 'Total Quantity', accessorKey: 'totalQty'),
    ];
  }

// Empty column
  return [
    // const MDDataTableColumns(title: 'empty', accessorKey: 'empty'),
  ];
}
