import 'package:flutter/material.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_scaffold/md_scaffold.dart';
import 'package:customer_app_mob/core/presentation/widgets/templates/home/menu_card.dart';

class HomeTemplate extends StatelessWidget {
  const HomeTemplate(
      {super.key,
      required this.username,
      required this.searchText,
      required this.menuList,
      required this.onTapMenu,
      required this.isMenuTapped,
      required this.currentRouteName});

  final String username;
  final TextEditingController searchText;
  final List<Map<String, dynamic>> menuList;
  final ValueChanged<String> onTapMenu;
  final bool isMenuTapped;
  final String currentRouteName;

  @override
  Widget build(BuildContext context) {
    return MDScaffold(
      appBarTitle: 'Home',
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, $username!',
              style: const TextStyle(
                  color: Color.fromRGBO(1, 34, 65, 1),
                  fontSize: 25,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600),
            ),
            Text(
              'Check out your Inventory',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 12),
            // Container or Expanded to constrain the height of the GridView
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 170.0,
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0),
                itemCount: menuList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    key: key,
                    onTap: menuList[index]['route'] != null
                        ? () {
                            onTapMenu(menuList[index]['route']);
                          }
                        : null,
                    child: MenuCard(
                      key: key,
                      menuList: menuList,
                      index: index,
                      isMenuTapped: isMenuTapped &&
                          menuList[index]['route'] == currentRouteName,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
