import 'package:flutter/material.dart';

abstract class SegmentedValue {
  const SegmentedValue();
}

class SegmentedValueMap extends SegmentedValue {
  const SegmentedValueMap({this.label, this.value});

  final String? value;
  final String? label;

  static const empty = SegmentedValueMap();
}

class SegmentedValueString extends SegmentedValue {
  const SegmentedValueString(this.value);

  final String value;
}

class ButtonSegmented<T> extends StatelessWidget {
  const ButtonSegmented({
    super.key,
    required this.segmentButtonStyles,
    required this.dataList,
    required this.selectedValue,
    required this.onSelectedChanged,
  });

  final ButtonStyle segmentButtonStyles;
  final List<T> dataList;
  final T selectedValue;
  final void Function(Set<T> newSelection) onSelectedChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      showSelectedIcon: false,
      style: segmentButtonStyles,
      segments: dataList
          .map(
            (e) => ButtonSegment(
              value: e,
              label: Text(
                  e is SegmentedValueMap ? e.label.toString() : e.toString()),
            ),
          )
          .toList(),
      selected: <T>{selectedValue},
      onSelectionChanged: onSelectedChanged,
    );
  }
}
