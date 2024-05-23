import 'package:flutter/material.dart';

class ClearButton extends StatelessWidget {
  const ClearButton({
    super.key,
    required this.mediaSize,
    this.onTap,
  });

  final Size mediaSize;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mediaSize.width,
      child: InkWell(
        onTap: onTap,
        enableFeedback: false,
        child: const Text(
          'Clear filter',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
