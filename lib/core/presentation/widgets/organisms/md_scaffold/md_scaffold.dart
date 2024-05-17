import 'package:flutter/material.dart';

class MDScaffold extends StatelessWidget {
  const MDScaffold({
    super.key,
    this.child,
    this.appBarTitle = '',
    this.showFloatingActionButton = false,
    this.floatingActionButtonLoc = FloatingActionButtonLocation.endFloat,
  });

  final Widget? child;

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
      appBar: appBarTitle.isNotEmpty ? appBar(context) : null,
      floatingActionButtonLocation: floatingActionButtonLoc,
      floatingActionButton: floatingActionButton(context),
      body: child != null ? SafeArea(child: child as Widget) : null,
    );
  }
}
