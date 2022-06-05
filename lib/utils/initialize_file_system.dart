import 'dart:io';

import 'package:note_app_desktop/class/note_store.dart';
import 'package:note_app_desktop/utils/local_dir.dart';

Future<void> initializeApp() async {
  final localPath = await getNotesPath();

  Directory dir = Directory(localPath);

  if(!await dir.exists()) {
    dir = await dir.create();
  }

  File store = File('${dir.path}/store.json');

  if(!await store.exists()) {
    store = await store.create();
  }

  String json = await store.readAsString();
  NoteRepository repo = NoteRepository([]);

  if(json.isEmpty) {
    await repo.update();
  }
}