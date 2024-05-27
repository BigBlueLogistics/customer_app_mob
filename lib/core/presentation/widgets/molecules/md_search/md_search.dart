import 'package:flutter/material.dart';
import 'package:customer_app_mob/core/shared/enums/text_border_type.dart';
import 'package:customer_app_mob/core/presentation/widgets/atoms/md_text_input/md_text_form.dart';

class MDSearch extends StatelessWidget {
  const MDSearch(
      {super.key,
      required this.textController,
      this.onClear,
      this.onInputChanged});

  final TextEditingController textController;

  final VoidCallback? onClear;

  final ValueChanged<String>? onInputChanged;

  @override
  Widget build(BuildContext context) {
    return MDTextFormField(
      textController: textController,
      onChanged: onInputChanged,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
      hintText: 'Search...',
      suffixIcon: IconButton(
        style: const ButtonStyle(
          padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
          ),
          maximumSize: WidgetStatePropertyAll(Size(40.0, 40.0)),
          minimumSize: WidgetStatePropertyAll(Size(30.0, 30.0)),
        ),
        icon: Icon(
          textController.text.isNotEmpty ? Icons.clear : Icons.search_outlined,
          color: Colors.black54,
        ),
        onPressed: textController.text.isNotEmpty ? onClear : null,
      ),
      borderType: TextFormBorderType.outline,
      borderColor: Colors.grey.shade200,
      filled: true,
      filledColor: Colors.white,
    );
  }
}
