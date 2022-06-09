import 'package:flutter/material.dart';
import 'package:note_app_desktop/src/components/navigation.dart';

class Sidenav extends StatefulWidget {
  const Sidenav({Key? key}) : super(key: key);

  @override
  State<Sidenav> createState() => _SidenavState();
}

class _SidenavState extends State<Sidenav> {
  ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _controller,
      child: Container(
        color: Theme.of(context).drawerTheme.backgroundColor,
        width: 300,
        height: MediaQuery.of(context).size.height,
        child: const Navigation(),
      ),
    );
  }
}
