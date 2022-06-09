import 'package:flutter/material.dart';
import 'package:note_app_desktop/src/components/navigation_item.dart';

class Navigation extends StatelessWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          NavigationItem(title: "Accueil"),
          NavigationItem(title: "Accueil"),
          NavigationItem(title: "Accueil"),
        ],
      ),
    );
  }
}
