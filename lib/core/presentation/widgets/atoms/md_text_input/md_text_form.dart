import 'package:flutter/material.dart';

class MDTextFormField extends StatelessWidget {
  final TextEditingController textController;
  final String labelText;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final bool autocorrect;
  final bool enableSuggestions;
  final bool obscureText;
  final Widget? suffixIcon;

  const MDTextFormField({
    super.key,
    required this.textController,
    required this.labelText,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.suffixIcon,
  });

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
      style: const TextStyle(height: 1),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.black87),
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
