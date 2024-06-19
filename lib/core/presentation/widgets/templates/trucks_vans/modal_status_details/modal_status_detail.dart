import 'package:flutter/material.dart';
import 'package:customer_app_mob/config/constants/text.dart';
import 'package:customer_app_mob/core/utils/utils.dart';
import 'card_layout.dart';

class ModalStatusDetails extends StatelessWidget {
  const ModalStatusDetails(
      {super.key, required this.dataDetails, required this.connectionState});

  final Map<String, dynamic> dataDetails;
  final ConnectionState connectionState;
  final String dateFormat = 'MM/dd/y, hh:mm a';

  Widget rowHeader(
      {required String? data,
      required Widget Function(String data) callbackChild}) {
    if (data != null) {
      return callbackChild(data);
    }
    return const SizedBox();
  }

  Row rowLabel({required String label, String? value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(
          value != null && value.isNotEmpty
              ? value.toString().toUpperCase()
              : 'n/a',
        )
      ],
    );
  }

  Widget pluginInfo(List<dynamic> pluginData) {
    if (pluginData.isNotEmpty) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: pluginData.map((plug) {
            return Row(
              children: [
                rowLabel(
                    label: '',
                    value: formatDate(
                        '${plug['startdate']} ${plug['starttime']}',
                        dateFormat)),
                const Text(' - '),
                rowLabel(
                    label: '',
                    value: formatDate(
                        '${plug['enddate']} ${plug['endtime']}', dateFormat)),
                Text(' (${plug['totalplughrs'] ?? 0} HR)')
              ],
            );
          }).toList(),
        ),
      );
    }

    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppConstantText.noDataAvailable),
      ],
    );
  }

  SizedBox remarksInfo(String? remarks) {
    return SizedBox(
      width: double.infinity,
      child: remarks != null && remarks.toString().trim().isNotEmpty
          ? Text(remarks)
          : const Text(
              AppConstantText.noDataAvailable,
              textAlign: TextAlign.center,
            ),
    );
  }

  cardDetails(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          rowHeader(
            data: dataDetails['vanno'],
            callbackChild: (data) => Text(data,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold, height: 2)),
          ),
          rowHeader(
            data: dataDetails['vmrno'],
            callbackChild: (data) => Text('VMR $data'),
          ),
          Row(
            children: [
              rowHeader(
                data: dataDetails['type'],
                callbackChild: (data) => Text(data),
              ),
              const Text(' - '),
              rowHeader(
                data: dataDetails['size'],
                callbackChild: (data) => Text(data),
              ),
            ],
          ),
          rowHeader(
            data: dataDetails['forwarder'],
            callbackChild: (data) => Text(data),
          ),
          CardLayout(
            title: 'ARRIVAL INFO',
            child: Column(children: [
              rowLabel(
                  label: 'Date & Time:',
                  value: formatDate(
                      '${dataDetails['arrivaldate']} ${dataDetails['arrivaltime']}',
                      dateFormat)),
              rowLabel(
                  label: 'Seal:', value: dataDetails['arrivalsealno'] ?? ''),
              rowLabel(
                  label: 'Delivery No.:',
                  value: dataDetails['arrivaldeliveryno'] ?? ''),
              rowLabel(
                  label: 'Status:', value: dataDetails['arrivalstatus'] ?? ''),
            ]),
          ),
          CardLayout(
            title: 'WAREHOUSE INFO',
            child: Column(children: [
              rowLabel(
                  label: 'Scheduled:',
                  value:
                      formatDate(dataDetails['whschedule'] ?? '', dateFormat)),
              rowLabel(
                  label: 'Process Start:',
                  value: formatDate(
                      '${dataDetails['whprocessstartdate']} ${dataDetails['whprocessstarttime']}',
                      dateFormat)),
              rowLabel(
                  label: 'Process End:',
                  value: formatDate(
                      dataDetails['whprocessend'] ?? '', dateFormat)),
            ]),
          ),
          CardLayout(
            title: 'DEPARTURE INFO',
            child: Column(children: [
              rowLabel(
                  label: 'Date & Time:',
                  value: formatDate(
                      '${dataDetails['outdate']} ${dataDetails['outtime']}',
                      dateFormat)),
              rowLabel(label: 'Seal:', value: dataDetails['outsealno'] ?? ''),
              rowLabel(
                  label: 'Delivery No.:',
                  value: dataDetails['outdeliveryno'] ?? ''),
              rowLabel(label: 'Status:', value: dataDetails['outstatus'] ?? ''),
            ]),
          ),
          CardLayout(
            title: 'PLUG-IN INFO',
            child: pluginInfo(dataDetails['plugin']),
          ),
          CardLayout(
            title: 'REMARKS',
            child: remarksInfo(dataDetails['remarks']),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
      child: switch (connectionState) {
        ConnectionState.active ||
        ConnectionState.waiting =>
          const Center(heightFactor: 4, child: CircularProgressIndicator()),
        ConnectionState.none => const Center(
            heightFactor: 4, child: Text(AppConstantText.noDataAvailable)),
        ConnectionState.done => cardDetails(context),
      },
    );
  }
}
