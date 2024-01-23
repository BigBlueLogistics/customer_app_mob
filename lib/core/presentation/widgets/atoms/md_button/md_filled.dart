import 'package:flutter/material.dart';

class MDFilledButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final MainAxisAlignment horizontalAlignment;
  final double height;
  final String text;
  final bool autoResize;
  final bool disabled;
  final bool loading;

  const MDFilledButton(
      {super.key,
      required this.onPressed,
      this.text = 'button',
      this.autoResize = true,
      this.horizontalAlignment = MainAxisAlignment.center,
      this.disabled = false,
      this.loading = false,
      this.height = 50});

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    // If text is provided
    if (text.isNotEmpty && !loading) {
      children.add(Text(
        text,
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8),
      ));
    }

    if (loading) {
      children.add(const CircularProgressIndicator(
        color: Colors.white54,
      ));
    }

    return Opacity(
      opacity: disabled && !loading ? 0.4 : 1,
      child: Container(
        height: height,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(
            begin: Alignment(-1, 1),
            end: Alignment(0, 0),
            colors: [
              Color.fromRGBO(73, 163, 241, 1),
              Color.fromRGBO(26, 115, 232, 1),
            ],
            transform: GradientRotation(195),
          ),
        ),
        child: TextButton(
          onPressed: disabled ? null : onPressed,
          child: Row(
            mainAxisSize: autoResize ? MainAxisSize.max : MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: horizontalAlignment,
            children: children,
          ),
        ),
      ),
    );
  }
}
