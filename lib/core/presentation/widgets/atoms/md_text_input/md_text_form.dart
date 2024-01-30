import 'package:flutter/material.dart';

import 'package:customer_app_mob/core/shared/enums/text_border_type.dart';

class MDTextFormField extends StatelessWidget {
  const MDTextFormField({
    super.key,
    required this.textController,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.obscureText = false,
    this.labelText,
    this.hintText,
    this.keyboardType,
    this.validator,
    this.suffixIcon,
    this.style = const TextStyle(height: 1),
    this.contentPadding,
    this.borderType = TextFormBorderType.underline,
    this.filled,
    this.filledColor,
    this.borderColor = Colors.grey,
  });

  final TextEditingController textController;
  final bool autocorrect;
  final bool enableSuggestions;
  final bool obscureText;
  final String? labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final TextStyle? style;
  final EdgeInsetsGeometry? contentPadding;
  final TextFormBorderType? borderType;
  final bool? filled;
  final Color? filledColor;
  final Color borderColor;

  InputBorder? enableBorder() {
    if (borderType case TextFormBorderType.outline) {
      return OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.elliptical(5.0, 5.0)),
        borderSide: BorderSide(
          color: borderColor,
          width: 1,
        ),
      );
    }

    if (borderType == TextFormBorderType.filled) {
      return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.elliptical(5.0, 5.0)),
        borderSide: BorderSide.none,
      );
    }

    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: borderColor,
        width: 1,
      ),
    );
  }

  InputBorder? focusedBorder() {
    if (borderType
        case TextFormBorderType.outline || TextFormBorderType.filled) {
      return OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.elliptical(5.0, 5.0)),
        borderSide: BorderSide(
          color: borderColor,
          width: 1,
        ),
      );
    }

    return UnderlineInputBorder(
      borderSide: BorderSide(color: borderColor, width: 1),
    );
  }

  InputBorder? errorBorder() {
    if (borderType
        case TextFormBorderType.outline || TextFormBorderType.filled) {
      return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.elliptical(5.0, 5.0)),
        borderSide: BorderSide(color: Colors.red, width: 1),
      );
    }

    return const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: textController,
      keyboardType: keyboardType,
      autocorrect: autocorrect,
      enableSuggestions: enableSuggestions,
      obscureText: obscureText,
      style: style,
      decoration: InputDecoration(
        prefixIconConstraints: const BoxConstraints(),
        suffixIconConstraints: const BoxConstraints(),
        contentPadding: contentPadding,
        labelText: labelText,
        labelStyle: TextStyle(
          color: Theme.of(context).hintColor,
          fontSize: Theme.of(context).textTheme.labelLarge?.fontSize,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: Theme.of(context).textTheme.labelLarge?.fontSize,
        ),
        filled: filled,
        fillColor: filledColor,
        enabledBorder: enableBorder(),
        focusedBorder: focusedBorder(),
        errorBorder: errorBorder(),
        focusedErrorBorder: errorBorder(),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }
}
