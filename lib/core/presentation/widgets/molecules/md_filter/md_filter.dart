import 'package:flutter/material.dart';

class MDFilter extends StatelessWidget {
  const MDFilter({
    super.key,
    this.onSelectCustomer,
    this.selectedCustomer,
    this.onFilter,
    this.menuList,
  });

  final VoidCallback? onSelectCustomer;
  final String? selectedCustomer;
  final VoidCallback? onFilter;
  final List<MenuItemButton>? menuList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      decoration: const BoxDecoration(
        border: BorderDirectional(bottom: BorderSide(color: Colors.grey)),
      ),
      child: Row(children: [
        Expanded(
          flex: 2,
          child: TextButton(
            onPressed: onSelectCustomer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedCustomer != null && selectedCustomer!.isNotEmpty
                      ? selectedCustomer.toString()
                      : 'Select customer',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black87,
                ),
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: onFilter,
          icon: const Icon(
            Icons.filter_list_outlined,
            size: 22.0,
            color: Colors.black87,
          ),
        ),
        MenuAnchor(
          builder:
              (BuildContext context, MenuController controller, Widget? child) {
            return IconButton(
              onPressed: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              icon: const Icon(Icons.more_vert),
              tooltip: 'Show menu',
            );
          },
          menuChildren: menuList ??
              List<MenuItemButton>.generate(
                1,
                (index) => const MenuItemButton(
                    child: Text(
                  'No menu',
                  textDirection: TextDirection.rtl,
                )),
              ),
        ),
      ]),
    );
  }
}
