import 'package:flutter/material.dart';
import 'package:customer_app_mob/config/routes/app_router.dart';
import 'package:customer_app_mob/config/routes/app_routes.dart';
import 'package:customer_app_mob/core/presentation/widgets/atoms/md_button/md_filled.dart';
import 'package:customer_app_mob/config/theme/colors.dart';
import 'package:customer_app_mob/config/constants/text.dart';
import 'package:customer_app_mob/core/utils/utils.dart';

class MDScaffold extends StatelessWidget {
  const MDScaffold({
    super.key,
    this.child,
    this.onGoBack,
    this.appBarBottom,
    this.actions,
    this.appBarTitle = '',
    this.showFloatingActionButton = false,
    this.floatingActionButtonLoc = FloatingActionButtonLocation.endFloat,
  });

  final Widget? child;
  final VoidCallback? onGoBack;
  final PreferredSizeWidget? appBarBottom;
  final List<Widget>? actions;
  final String appBarTitle;
  final bool showFloatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLoc;

  FloatingActionButton? floatingActionButton(BuildContext context) {
    if (showFloatingActionButton) {
      return FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
        tooltip: 'Create Order',
        shape: const CircleBorder(side: BorderSide(color: Colors.transparent)),
        child: const Icon(Icons.add_rounded),
      );
    }
    return null;
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: Text(
        appBarTitle,
        style: const TextStyle(
            color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600),
      ),
      bottom: appBarBottom,
      centerTitle: true,
      leading: onGoBack != null
          ? BackButton(
              color: Colors.white,
              onPressed: onGoBack,
            )
          : null,
      actions: [
        ...?actions,
      ],
      scrolledUnderElevation: 3.0,
      backgroundColor: Theme.of(context).primaryColor,
      shadowColor: Theme.of(context).colorScheme.shadow,
      iconTheme: IconThemeData(color: Colors.white),
    );
  }

  Drawer drawer(BuildContext context) {
    List<ListTile> menuLists = [];
    AppRoutes.properties.forEach((key, value) {
      if (value.isPrivateRoute) {
        menuLists.add(ListTile(
          title: Text(value.title),
          leading: value.icon,
          onTap: () {
            AppRouter.router.go(value.fullPath);
          },
        ));
      }
    });

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.dark,
                ),
                child: Text(
                  AppConstantText.appName,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: AppColors.light),
                )),
          ),
          ...menuLists,
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: MDFilledButton(
                text: 'SIGN OUT',
                borderRadius: BorderRadius.zero,
                onPressed: () {
                  log('sign-out');
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: appBarTitle.isNotEmpty ? appBar(context) : null,
      floatingActionButtonLocation: floatingActionButtonLoc,
      floatingActionButton: floatingActionButton(context),
      body: child != null ? SafeArea(child: child as Widget) : null,
    );
  }
}
