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

    return const Stack(
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: 0.8,
          child: ModalBarrier(dismissible: false, color: Colors.black54),
        ),
        Center(
          child: Card(
              shape: CircleBorder(),
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: CircularProgressIndicator(),
              )),
        )
      ],
    );
  }
}
