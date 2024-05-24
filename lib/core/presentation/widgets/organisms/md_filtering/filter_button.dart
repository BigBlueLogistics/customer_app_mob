import 'package:customer_app_mob/core/presentation/widgets/atoms/md_button/md_filled.dart';
import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return MDFilledButton(
      text: 'Filter',
      height: 40,
      onPressed: onPressed,
    );
  }
}
