import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.mediaSize,
    required this.buttonBorderShape,
    this.onPressed,
  });

  final VoidCallback? onPressed;
  final Size mediaSize;
  final RoundedRectangleBorder buttonBorderShape;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
          minimumSize: Size(mediaSize.width, 35), shape: buttonBorderShape),
      child: const Text('Filter'),
    );
  }
}
