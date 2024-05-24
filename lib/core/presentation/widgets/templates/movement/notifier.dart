class FilterValueNotifier {
  const FilterValueNotifier({
    this.customerCode,
    this.materialCode,
    this.warehouse,
    this.coverageDate,
    this.movementType,
    this.materialList,
  });

  final String? customerCode;
  final String? materialCode;
  final String? warehouse;
  final String? movementType;
  final List<String>? coverageDate;
  final List<Map<String, dynamic>>? materialList;

  FilterValueNotifier copyWith(
      {String? customerCode,
      String? materialCode,
      String? warehouse,
      List<Map<String, dynamic>>? materialList,
      String? movementType,
      List<String>? coverageDate}) {
    return FilterValueNotifier(
      customerCode: customerCode ?? this.customerCode,
      materialCode: materialCode ?? this.materialCode,
      warehouse: warehouse ?? this.warehouse,
      materialList: materialList ?? this.materialList,
      coverageDate: coverageDate ?? this.coverageDate,
      movementType: movementType ?? this.movementType,
    );
  }

  static const empty = FilterValueNotifier();
}
