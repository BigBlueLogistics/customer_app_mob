class FilterValueNotifier {
  FilterValueNotifier({
    this.customerCode,
    this.materialCode,
    this.warehouse,
    this.coverageDate,
    this.movementType,
    this.materialList,
  });

  String? customerCode;
  String? materialCode;
  String? warehouse;
  String? movementType;
  List<String>? coverageDate;
  List<Map<String, dynamic>>? materialList;

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
}
