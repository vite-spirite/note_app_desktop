import 'dart:convert';
import 'dart:io';

import 'package:note_app_desktop/class/note.dart';
import 'package:note_app_desktop/utils/local_dir.dart';

class NoteRepository {
  List<Note> notes = [];

  NoteRepository(this.notes);

  factory NoteRepository.fromJson(String json) {
    List<dynamic> data = jsonDecode(json);
    List<Note> repo = [];

    for (var element in data) {
      repo.add(Note.fromJson(element));
    }

    return NoteRepository(repo);
  }

  Future<Note> create(String name) async {
    final localFile = await getNotesPath();

    File file = File('$localFile/${DateTime.now()}-${name.replaceAll(' ', '-')}');
    file = await file.create();

    final tmp = Note(created: DateTime.now(), updated: DateTime.now(), name: name, path: file.path);

    notes.add(tmp);
    return tmp;
  }

  Future<void> delete(String path) async {
    try {
      final ref = notes.firstWhere((element) => element.path == path);
      final index = notes.indexWhere((element) => element.path == path);

      if(index == -1) {
        throw "index not found";
      }

      await ref.delete();
      notes.removeAt(index);
    }
    catch(e) {
      return;
    }
  }

  Future<void> update() async {
    final localPath = await getNotesPath();

    File file = File('$localPath/store.json');

    if(!await file.exists()) {
      file = await file.create();
    }

    List<dynamic> json = [];

    for (var note in notes) {
      json.add(note.toJson());
    }

    print(jsonEncode(json));

    file.writeAsStringSync(jsonEncode(json));
  }
}