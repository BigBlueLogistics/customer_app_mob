import 'package:flutter/material.dart';

class ButtonSegmented extends StatelessWidget {
  const ButtonSegmented({
    super.key,
    required this.segmentButtonStyles,
    required this.dataList,
    required this.selectedValue,
    required this.onSelectedChanged,
  });

  final ButtonStyle segmentButtonStyles;
  final List<String> dataList;
  final String selectedValue;
  final void Function(Set<String> newSelection) onSelectedChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      showSelectedIcon: false,
      style: segmentButtonStyles,
      segments: dataList
          .map(
            (e) => ButtonSegment(
              value: e,
              label: Text(e),
            ),
          )
          .toList(),
      selected: <String>{selectedValue},
      onSelectionChanged: onSelectedChanged,
    );
  }
}
