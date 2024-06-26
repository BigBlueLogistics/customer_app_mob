import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app_mob/core/presentation/bloc/auth/auth_bloc.dart';
import 'drawer_scaffold.dart';

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

  void signOut(BuildContext context) async {
    context.read<AuthBloc>().add(AuthSignOut());
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerScaffold(signOut: () {
        signOut(context);
      }),
      appBar: appBarTitle.isNotEmpty ? appBar(context) : null,
      floatingActionButtonLocation: floatingActionButtonLoc,
      floatingActionButton: floatingActionButton(context),
      body: child != null ? SafeArea(child: child as Widget) : null,
    );
  }
}
