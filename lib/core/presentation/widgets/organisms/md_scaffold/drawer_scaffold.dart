import 'package:flutter/material.dart';
import 'package:customer_app_mob/config/constants/text.dart';
import 'package:customer_app_mob/config/routes/app_router.dart';
import 'package:customer_app_mob/config/routes/app_routes.dart';
import 'package:customer_app_mob/config/theme/colors.dart';
import 'package:customer_app_mob/core/presentation/widgets/atoms/md_button/md_filled.dart';

class DrawerScaffold extends StatelessWidget {
  const DrawerScaffold({super.key, required this.signOut});

  final void Function() signOut;

  SizedBox drawerHeader(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DrawerHeader(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(4.0))),
              height: 73,
              child: Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: 'Big',
                    style: TextStyle(
                        color: Color(0xFF0071c1),
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        height: 0),
                  ),
                  TextSpan(
                    text: 'Blue\n',
                    style: TextStyle(
                        color: Colors.white,
                        backgroundColor: Color(0xFF0071c1),
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        height: 0),
                  ),
                  TextSpan(
                    text: 'Logistics Corporation\n'.toUpperCase(),
                    style: TextStyle(
                        color: Color(0xFF0071c1),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.1,
                        height: 0),
                  ),
                ]),
                textScaler: TextScaler.linear(1.2),
              ),
            ),
            Text(
              AppConstantText.appName,
              style: TextStyle(color: AppColors.light, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }

  List<ListTile> menuList() {
    List<ListTile> menus = [];

    AppRoutes.properties.forEach((key, value) {
      if (value.isPrivateRoute) {
        menus.add(ListTile(
          title: Text(
            value.title,
            style: TextStyle(color: AppColors.text),
          ),
          leading: value.icon,
          onTap: () {
            AppRouter.router.go(value.fullPath);
          },
        ));
      }
    });

    return menus;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Drawer(
      width: screenSize.width * 0.70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          drawerHeader(context),
          ...menuList(),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: MDFilledButton(
                text: 'SIGN OUT',
                borderRadius: BorderRadius.zero,
                onPressed: signOut,
              ),
            ),
          )
        ],
      ),
    );
  }
}
