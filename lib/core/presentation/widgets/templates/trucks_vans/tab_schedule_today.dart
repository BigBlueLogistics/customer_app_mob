import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TabScheduleToday extends StatelessWidget {
  const TabScheduleToday({
    super.key,
    required this.onRefresh,
    required this.data,
  });

  final Future<void> Function() onRefresh;
  final List<Map<String, dynamic>> data;

  String formatArrivalDate(String date) {
    DateTime formattedDate = DateTime.parse(date);

    return DateFormat.yMMMd().add_jm().format(formattedDate);
  }

  Row RowLabel({required String label, required String value}) {
    return Row(
      children: [
        Text(label),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: data.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final scheduleData = data[index];

                  return Card(
                    key: ValueKey(index.toString()),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    elevation: 4,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(5, 5))),
                    child: ListTile(
                      title: Text(scheduleData['vehiclenum'],
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15.0)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RowLabel(
                              label: 'Type: ',
                              value: scheduleData['vehicletype']),
                          RowLabel(
                              label: 'Arrival: ',
                              value: formatArrivalDate(
                                  '${scheduleData['arrivaldate']} ${scheduleData['arrivaltime']}')),
                        ],
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 4.0),
                    ),
                  );
                },
              )
            : const Center(child: Text('No data available.')),
      ),
    );
  }
}
