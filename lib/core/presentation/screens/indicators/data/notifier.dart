class FilterValueNotifier {
  const FilterValueNotifier({
    this.customerCode,
  });

  final String? customerCode;

  FilterValueNotifier copyWith({
    String? customerCode,
  }) {
    return FilterValueNotifier(
      customerCode: customerCode ?? this.customerCode,
    );
  }

  static const empty = FilterValueNotifier();
}
