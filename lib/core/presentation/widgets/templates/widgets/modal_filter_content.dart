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
      required this.onFilterData,
      required this.onClearFilter});

  final List<String> customerList;
  final List<String> warehouseList;
  final ValueChanged<String> onSelectCustomer;
  final ValueChanged<String> onSelectWarehouse;
  final String selectedCustomer;
  final String selectedWarehouse;
  final VoidCallback onFilterData;
  final VoidCallback onClearFilter;

  @override
  State<ModalFilterContent> createState() => _ModalFilterContentState();
}

class _ModalFilterContentState extends State<ModalFilterContent> {
  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;
    const buttonBorderShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    );

    final segmentButtonStyles =
        SegmentedButton.styleFrom(shape: buttonBorderShape);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        height: mediaSize.height * 0.35,
        width: mediaSize.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Customer:',
              textAlign: TextAlign.center,
            ),
            widget.customerList.isNotEmpty
                ? CustomerSegmentedButton(
                    segmentButtonStyles: segmentButtonStyles, widget: widget)
                : const Text('---'),
            const SizedBox(
              width: 0,
              height: 10,
            ),
            const Text(
              'Warehouse:',
              textAlign: TextAlign.center,
            ),
            widget.warehouseList.isNotEmpty
                ? WarehouseSegmentedButton(
                    segmentButtonStyles: segmentButtonStyles, widget: widget)
                : const Text('---'),
            const SizedBox(
              width: 0,
              height: 15,
            ),
            FilterButton(
                widget: widget,
                mediaSize: mediaSize,
                buttonBorderShape: buttonBorderShape),
            ClearButton(widget: widget, mediaSize: mediaSize)
          ],
        ),
      ),
    );
  }
}

class ClearButton extends StatelessWidget {
  const ClearButton({
    super.key,
    required this.mediaSize,
    required this.widget,
  });

  final Size mediaSize;
  final ModalFilterContent widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mediaSize.width,
      child: InkWell(
        onTap: widget.customerList.isNotEmpty && widget.warehouseList.isNotEmpty
            ? widget.onClearFilter
            : null,
        enableFeedback: false,
        child: const Text(
          'Clear filter',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.widget,
    required this.mediaSize,
    required this.buttonBorderShape,
  });

  final ModalFilterContent widget;
  final Size mediaSize;
  final RoundedRectangleBorder buttonBorderShape;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed:
          widget.customerList.isNotEmpty && widget.warehouseList.isNotEmpty
              ? widget.onFilterData
              : null,
      style: FilledButton.styleFrom(
          minimumSize: Size(mediaSize.width, 35), shape: buttonBorderShape),
      child: const Text('Filter'),
    );
  }
}

class WarehouseSegmentedButton extends StatelessWidget {
  const WarehouseSegmentedButton({
    super.key,
    required this.segmentButtonStyles,
    required this.widget,
  });

  final ButtonStyle segmentButtonStyles;
  final ModalFilterContent widget;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      showSelectedIcon: false,
      style: segmentButtonStyles,
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
    );
  }
}

class CustomerSegmentedButton extends StatelessWidget {
  const CustomerSegmentedButton({
    super.key,
    required this.segmentButtonStyles,
    required this.widget,
  });

  final ButtonStyle segmentButtonStyles;
  final ModalFilterContent widget;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      style: segmentButtonStyles,
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
    );
  }
}
