import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    const textFieldEnabledBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    );

    const textFieldFocusedBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1.5),
    );

    const errorFieldFocusedBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1.5),
    );

    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: textController,
      keyboardType: keyboardType,
      autocorrect: autocorrect,
      enableSuggestions: enableSuggestions,
      obscureText: obscureText,
      style: style,
      decoration: InputDecoration(
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
        enabledBorder: textFieldEnabledBorder,
        focusedBorder: textFieldFocusedBorder,
        errorBorder: errorFieldFocusedBorder,
        focusedErrorBorder: errorFieldFocusedBorder,
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }
}
