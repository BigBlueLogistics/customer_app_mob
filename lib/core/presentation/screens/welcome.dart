import 'package:flutter/material.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_scaffold/md_scaffold.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MDScaffold(
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
              child: SizedBox(
            child: Center(child: Text('Welcome')),
          ))
        ],
      ),
    );
  }
}
