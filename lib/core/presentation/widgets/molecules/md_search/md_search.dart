import 'package:flutter/material.dart';
import 'package:customer_app_mob/core/shared/enums/text_border_type.dart';
import 'package:customer_app_mob/core/presentation/widgets/atoms/md_text_input/md_text_form.dart';

class MDSearch extends StatelessWidget {
  const MDSearch({super.key, required this.searchText});

  final TextEditingController searchText;

  @override
  Widget build(BuildContext context) {
    return MDTextFormField(
      textController: searchText,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
      hintText: 'Search...',
      suffixIcon: IconButton.filled(
        iconSize: 20.0,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
          ),
          backgroundColor:
              MaterialStatePropertyAll(Theme.of(context).primaryColor),
        ),
        icon: const Icon(
          Icons.search_outlined,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      borderType: TextFormBorderType.filled,
      borderColor: Theme.of(context).primaryColor,
      filled: true,
      filledColor: const Color.fromARGB(255, 255, 255, 255),
    );
  }
}
