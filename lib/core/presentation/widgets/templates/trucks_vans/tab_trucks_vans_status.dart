import 'dart:math' hide log;

import 'package:flutter/material.dart';
import 'package:customer_app_mob/config/constants/text.dart';
import 'package:customer_app_mob/core/utils/utils.dart';
import 'package:customer_app_mob/core/presentation/screens/error.dart';
import 'package:customer_app_mob/core/domain/entities/trucks_vans.dart';
import 'package:customer_app_mob/core/presentation/widgets/templates/trucks_vans/modal_status_details/modal_status_detail.dart';

class TabTrucksVansStatus extends StatelessWidget {
  const TabTrucksVansStatus(
      {super.key,
      required this.onRefresh,
      required this.data,
      required this.getStatusDetails});

  final Future<void> Function() onRefresh;
  final List<Map<String, dynamic>> data;
  final Future<DataState<TrucksVansStatusDetailsEntity>> Function(
      String vanMonitorNo) getStatusDetails;

  String whLocation(String location) {
    if (location.isNotEmpty) {
      return ['TRUCK', 'YARD'].contains(location.toUpperCase())
          ? 'CONTAINER / TRUCK YARD'
          : 'WAREHOUSE $location';
    }
    return '';
  }

  int arrivalAgeByDay(String date) {
    DateTime formattedDate = DateTime.parse(date).toLocal();

    return DateTime.now().difference(formattedDate).inDays;
  }

  String status(
      {required String? whdate,
      required String? currentstatus,
      required String? arrivalstatus,
      required String? whschedule}) {
    if (whdate != null) {
      if (currentstatus != null) {
        return currentstatus.toUpperCase();
      }
      return 'PROCESSED';
    }
    if (whschedule != null) {
      return 'SCHEDULED $whschedule';
    }
    return arrivalstatus != null ? arrivalstatus.toUpperCase() : '';
  }

  Row rowLabel({required String label, required String value}) {
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

  Widget plugIcon(String? plugStatus) {
    if (plugStatus != null && plugStatus == 'PLUGGED-IN') {
      return Transform.rotate(
        angle: 45 * pi / 180,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.power_rounded, color: Colors.green, size: 28),
        ),
      );
    }

    if (plugStatus != null && plugStatus == 'PLUGGED-OUT') {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(Icons.power_off_rounded, size: 28),
      );
    }

    return const SizedBox();
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
                  final statusData = data[index];

                  return Card(
                    key: ValueKey(index.toString()),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    elevation: 1,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(5, 5))),
                    child: ListTile(
                      title: Text.rich(TextSpan(children: [
                        TextSpan(
                            text: statusData['vanno'],
                            style: const TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w500)),
                        const TextSpan(text: ' '),
                        TextSpan(
                            text: '(VMR ${statusData['vmrno']})',
                            style: const TextStyle(fontSize: 13.0)),
                      ])),
                      subtitle: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            rowLabel(
                                label: 'Location: ',
                                value: whLocation(statusData['location'])),
                            rowLabel(
                                label: 'Type / Size: ',
                                value:
                                    '${statusData['type']} / ${statusData['size']}'),
                            rowLabel(
                                label: 'Arrival: ',
                                value:
                                    '${formatDate(statusData['arrivaldate'])} (${arrivalAgeByDay(statusData['arrivaldate'])} day\'s)'),
                            rowLabel(
                                label: 'Status: ',
                                value: status(
                                    whdate: statusData['whdate'],
                                    currentstatus: statusData['currentstatus'],
                                    arrivalstatus: statusData['arrivalstatus'],
                                    whschedule: statusData['whschedule']))
                          ],
                        ),
                      ),
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            isDismissible: true,
                            showDragHandle: false,
                            enableDrag: false,
                            useSafeArea: true,
                            isScrollControlled: true,
                            scrollControlDisabledMaxHeightRatio: 1,
                            builder: (context) {
                              return FutureBuilder(
                                future: getStatusDetails(statusData['vmrno']),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError ||
                                      snapshot.data is DataFailed) {
                                    return ErrorScreen(Exception(snapshot.data
                                            ?.error?.response?.statusMessage ??
                                        snapshot.data?.error?.type));
                                  } else {
                                    return ModalStatusDetails(
                                        connectionState:
                                            snapshot.connectionState,
                                        dataDetails:
                                            snapshot.data?.resp!.data ?? {});
                                  }
                                },
                              );
                            });
                      },
                      trailing: plugIcon(statusData['pluggedstatus']),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 4.0),
                    ),
                  );
                },
              )
            : const Center(child: Text(AppConstantText.noDataAvailable)),
      ),
    );
  }
}
