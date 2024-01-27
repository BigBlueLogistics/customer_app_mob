import 'package:flutter/material.dart';
import 'package:customer_app_mob/core/presentation/widgets/atoms/md_text_input/md_text_form.dart';

class MDSearchMore extends StatelessWidget {
  const MDSearchMore({super.key, required this.searchText});

  final TextEditingController searchText;

  @override
  Widget build(BuildContext context) {
    return MDTextFormField(
      textController: searchText,
      hintText: 'Search',
      contentPadding: const EdgeInsetsDirectional.only(top: 15, start: 10),
      suffixIcon: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_outlined,
              color: Colors.black87,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.filter_list_outlined,
              color: Colors.black87,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert_outlined,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
