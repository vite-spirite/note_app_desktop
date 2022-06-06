import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app_desktop/src/sidebar.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }

  static Widget _build(Widget body) {
    return SharedScallfold(body: body);
  }

  final _router = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (ctx, state) => _build(
          const TestHome(number: 1),
        ),
      ),
      GoRoute(
        path: '/index/:id',
        name: 'index',
        builder: (ctx, state) => _build(
          TestHome(
            number: int.parse(state.params['id'] ?? '0'),
          ),
        ),
      ),
    ],
  );
}

class SharedScallfold extends StatelessWidget {
  final Widget body;
  const SharedScallfold({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController contentScrollController = ScrollController();

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Drawer(
            width: 300,
            elevation: 0,
            child: Sidebar(),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 300,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              controller: contentScrollController,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: body,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> fakeNav(BuildContext context) {
  List<Widget> fake = [];

  for (var i = 0; i < 50; i++) {
    fake.add(
      ListTile(
        title: Text('item $i'),
        onTap: () => context.goNamed('index', params: {'id': '$i'}),
      ),
    );
  }

  return fake;
}

class TestHome extends StatelessWidget {
  final int number;
  const TestHome({Key? key, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('$number');
  }
}
