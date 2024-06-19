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

    const loadingIconPos =
        kToolbarHeight + kBottomNavigationBarHeight + kTextTabBarHeight;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Opacity(
          opacity: 0.2,
          child: ModalBarrier(dismissible: false, color: Colors.black54),
        ),
        Positioned.directional(
          top: loadingIconPos,
          textDirection: TextDirection.ltr,
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
