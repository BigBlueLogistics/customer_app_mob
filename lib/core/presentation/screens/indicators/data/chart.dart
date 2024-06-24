class ChartData {
  const ChartData(
      {required this.title, required this.dates, required this.values});

  final String title;
  final List<dynamic> dates;
  final List<dynamic> values;

  ChartData copyWith(
      {String? title, List<dynamic>? dates, List<dynamic>? values}) {
    return ChartData(
        title: title ?? this.title,
        dates: dates ?? this.dates,
        values: values ?? this.values);
  }
}

final Map<String, ChartData> chartList = {
  'inbound': ChartData(title: 'By Weight', dates: [], values: []),
  'outbound': ChartData(title: 'By Transactions', dates: [], values: []),
};
