class FilterValueNotifier {
  FilterValueNotifier({
    this.customerCode,
    this.warehouse,
  });

  String? customerCode;
  String? warehouse;

  FilterValueNotifier copyWith({
    String? customerCode,
    String? warehouse,
  }) {
    return FilterValueNotifier(
        customerCode: customerCode ?? this.customerCode,
        warehouse: warehouse ?? this.warehouse);
  }
}
