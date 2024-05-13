import 'dart:ui';

import 'package:flutter/material.dart';

class MDLoadingFullScreen extends StatelessWidget {
  const MDLoadingFullScreen({
    super.key,
    this.isLoading = false,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return const SizedBox();
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          child: const Opacity(
            opacity: 0.8,
            child: ModalBarrier(dismissible: false, color: Colors.transparent),
          ),
        ),
        const Center(
          child: CircularProgressIndicator(),
        )
      ],
    );
  }
}
