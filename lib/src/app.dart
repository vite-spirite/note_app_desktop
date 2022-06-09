import 'package:flutter/material.dart';
import 'package:note_app_desktop/src/components/sidenav.dart';

class MyLayout extends StatefulWidget {
  final String title;

  final Widget body;
  final FloatingActionButton? fab;

  const MyLayout({Key? key, required this.title, required this.body, this.fab})
      : super(key: key);

  @override
  State<MyLayout> createState() => _MyLayoutState();
}

class _MyLayoutState extends State<MyLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Sidenav(), widget.body],
        ),
      ),
      floatingActionButton: widget.fab,
    );
  }
}
