import 'package:flutter/material.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_scaffold/md_bottom_navigation.dart';

class MDScaffold extends StatelessWidget {
  const MDScaffold({
    super.key,
    this.body,
    this.appBarTitle = '',
    this.selectedBarIndex = 0,
    this.showFloatingActionButton = false,
    this.floatingActionButtonLoc = FloatingActionButtonLocation.endFloat,
  });

  final Widget? body;

  final String appBarTitle;

  final int selectedBarIndex;

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
      centerTitle: true,
      leading: BackButton(
        color: Colors.white,
        onPressed: () {},
      ),
      actions: [
        IconButton(
          onPressed: () => {},
          icon: const Icon(
            Icons.menu_rounded,
            color: Colors.white,
          ),
        ),
      ],
      scrolledUnderElevation: 3.0,
      backgroundColor: Theme.of(context).primaryColor,
      shadowColor: Theme.of(context).colorScheme.shadow,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      floatingActionButtonLocation: floatingActionButtonLoc,
      floatingActionButton: floatingActionButton(context),
      bottomNavigationBar:
          MDBottomNavigationBar(selectedBarIndex: selectedBarIndex),
      body: body,
    );
  }
}
