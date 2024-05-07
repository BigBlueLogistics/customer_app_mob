import 'package:flutter/material.dart';

class ModalFilterContent extends StatefulWidget {
  const ModalFilterContent(
      {super.key,
      required this.customerList,
      required this.warehouseList,
      required this.onSelectCustomer,
      required this.onSelectWarehouse,
      required this.selectedCustomer,
      required this.selectedWarehouse,
      required this.generateData,
      required this.onClearFilter});

  final List<String> customerList;
  final List<String> warehouseList;
  final ValueChanged<String> onSelectCustomer;
  final ValueChanged<String> onSelectWarehouse;
  final String selectedCustomer;
  final String selectedWarehouse;
  final void Function({required String customerCode, required String warehouse})
      generateData;
  final VoidCallback onClearFilter;

  @override
  State<ModalFilterContent> createState() => _ModalFilterContentState();
}

class _ModalFilterContentState extends State<ModalFilterContent> {
  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        height: mediaSize.height * 0.35,
        width: mediaSize.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Customer:  ',
              textAlign: TextAlign.center,
            ),
            SegmentedButton(
              showSelectedIcon: false,
              segments: widget.customerList
                  .map(
                    (e) => ButtonSegment(
                      value: e,
                      label: Text(e),
                    ),
                  )
                  .toList(),
              selected: <String>{widget.selectedCustomer},
              onSelectionChanged: (Set<String> newSelection) {
                widget.onSelectCustomer(newSelection.first);
              },
            ),
            const SizedBox(
              width: 0,
              height: 10,
            ),
            const Text(
              'Warehouse:',
              textAlign: TextAlign.center,
            ),
            SegmentedButton(
              showSelectedIcon: false,
              segments: widget.warehouseList
                  .map(
                    (e) => ButtonSegment(
                      value: e,
                      label: Text(e),
                    ),
                  )
                  .toList(),
              selected: <String>{widget.selectedWarehouse},
              onSelectionChanged: (Set<String> newSelection) {
                widget.onSelectWarehouse(newSelection.first);
              },
            ),
            const SizedBox(
              width: 0,
              height: 15,
            ),
            FilledButton(
              onPressed: () => widget.generateData(
                  customerCode: widget.selectedCustomer,
                  warehouse: widget.selectedWarehouse),
              style: FilledButton.styleFrom(
                minimumSize: Size(mediaSize.width, 35),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              child: const Text('Filter'),
            ),
            SizedBox(
              width: mediaSize.width,
              child: InkWell(
                onTap: widget.onClearFilter,
                enableFeedback: false,
                child: const Text(
                  'Clear filter',
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
