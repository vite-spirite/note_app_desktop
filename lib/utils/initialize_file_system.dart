import 'dart:io';

import 'package:note_app_desktop/utils/local_dir.dart';

Future<void> initializeApp() async {
  final localPath = await getLocalPath();

  Directory dir = Directory('$localPath/notes');

  if(!await dir.exists()) {
    dir = await dir.create();
  }

  File store = File('${dir.path}/store.json');

  if(!await store.exists()) {
    store = await store.create();
  }
}