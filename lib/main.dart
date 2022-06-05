import 'dart:io';

import 'package:flutter/material.dart';
import 'package:note_app_desktop/utils/initialize_file_system.dart';
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if(Platform.isLinux) {
    setWindowMinSize(const Size(800, 480));
    setWindowTitle('note app');
  }

  await initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(width: 300.0,color: Theme.of(context).primaryColor, child: ListView(shrinkWrap: true, padding: const EdgeInsets.all(16.0), children: const [ListTile(title: Text('barre de navigation'))],),),
          const SizedBox(width: 16.0,),
          const Text("page content"),
        ],
      ),
    );
  }
}