class FilterValueNotifier {
  const FilterValueNotifier({
    this.customerCode,
    this.warehouse,
  });

  final String? customerCode;
  final String? warehouse;

  FilterValueNotifier copyWith({
    String? customerCode,
    String? warehouse,
  }) {
    return FilterValueNotifier(
        customerCode: customerCode ?? this.customerCode,
        warehouse: warehouse ?? this.warehouse);
  }

  static const empty = FilterValueNotifier();
}
