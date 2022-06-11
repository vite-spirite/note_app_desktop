import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app_desktop/bloc/note_bloc.dart';
import 'package:note_app_desktop/class/note_store.dart';
import 'package:note_app_desktop/src/app.dart';
import 'package:note_app_desktop/src/page/note_create.dart';
import 'package:note_app_desktop/src/page/note_list.dart';
import 'package:note_app_desktop/utils/initialize_file_system.dart';
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    setWindowMinSize(const Size(800, 480));
    setWindowTitle('note app');
  }

  final repository = await initializeApp();

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final NoteRepository repository;

  const MyApp({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => repository,
      child: BlocProvider(
        create: (ctx) => NoteBloc(
          RepositoryProvider.of<NoteRepository>(ctx),
        ),
        child: MyMaterialApp(),
      ),
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  MyMaterialApp({Key? key}) : super(key: key);

  static Widget _build({required Widget child, FloatingActionButton? fab}) =>
      MyLayout(
        title: "Notes",
        body: child,
        fab: fab,
      );

  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, __) =>
            RepositoryProvider.of<NoteRepository>(context).notes.isNotEmpty
                ? _build(child: NoteList())
                : _build(child: NoteCreate()),
      ),
      GoRoute(
        path: '/new',
        builder: (_, __) => _build(child: NoteCreate()),
      ),
      GoRoute(
          path: '/index/:id',
          builder: (_, state) => _build(
              child: Text('Visualisation du document: ${state.params["id"]}')))
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
          primaryColor: const Color(0xFF164b7c),
          scaffoldBackgroundColor: const Color(0xFFE4E8E8),
          drawerTheme:
              const DrawerThemeData(backgroundColor: Color(0xFF1D2A3B)),
          useMaterial3: true),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
    );
  }
}
