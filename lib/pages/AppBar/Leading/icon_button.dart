import 'package:flutter/material.dart';

class Leading extends StatelessWidget {
  const Leading({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(10),
      icon: const Icon(
        Icons.menu_rounded,
        size: 30,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
    );
  }
}
