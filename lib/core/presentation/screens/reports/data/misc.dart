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
  const MDDataTableColumns(title: 'MATERIAL CODE', accessorKey: 'materialCode'),
  const MDDataTableColumns(title: 'DESCRIPTION', accessorKey: 'description'),
  const MDDataTableColumns(title: 'FIXED WEIGHT', accessorKey: 'fixedWt'),
];
List<MDDataTableColumns> columnSnapshot(SegmentedValueMap? snapshotGroupBy) {
  final headers = [
    const MDDataTableColumns(
        title: 'AVAILABLE STOCKS', accessorKey: 'availableQty'),
    const MDDataTableColumns(
        title: 'ALLOCATED STOCKS', accessorKey: 'allocatedQty'),
    const MDDataTableColumns(
        title: 'RESTRICTED STOCKS', accessorKey: 'restrictedQty'),
    const MDDataTableColumns(title: 'TOTAL STOCKS', accessorKey: 'totalQty'),
  ];

  // Group by index[0] = Material.
  if (snapshotGroupBy?.value == _groupBySnapshotList[0].value) {
    return [..._commonHeaders, ...headers];
  }

  // Group by index[1] = Batch.
  if (snapshotGroupBy?.value == _groupBySnapshotList[1].value) {
    return [
      ..._commonHeaders,
      const MDDataTableColumns(title: 'BATCH / LOT', accessorKey: 'batch'),
      const MDDataTableColumns(title: 'EXPIRY DATE', accessorKey: 'expiry'),
      ...headers
    ];
  }

  // Group by index[2] = Expiry.
  if (snapshotGroupBy?.value == _groupBySnapshotList[2].value) {
    return [
      ..._commonHeaders,
      const MDDataTableColumns(title: 'EXPIRY DATE', accessorKey: 'expiry'),
      ...headers
    ];
  }

  // Empty column
  return [];
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
          title: 'RECEIPTS NOW', accessorKey: 'qty_expired'),
      const MDDataTableColumns(
          title: 'TOTAL QUANTITY', accessorKey: 'totalQty'),
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
          title: 'EXPIRED PRODUCS', accessorKey: 'qty_expired'),
      const MDDataTableColumns(
          title: 'TOTAL QUANTITY', accessorKey: 'totalQty'),
    ];
  }

// Empty column
  return [];
}
