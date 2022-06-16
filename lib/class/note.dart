import 'dart:convert';
import 'dart:io';

import 'package:flutter_quill/flutter_quill.dart';

class Note {
  String path;
  String name;
  DateTime updated;
  DateTime created;

  bool loaded = false;
  Document text = Document();

  Document get getText => text;

  String get createdUTCDate =>
      '${created.day}/${created.month}/${created.year}';
  String get updatedUTCDate =>
      '${updated.day}/${updated.month}/${updated.year}';

  Note(
      {required this.path,
      required this.name,
      required this.updated,
      required this.created});

  Note.fromJson(dynamic data)
      : path = data['file'],
        name = data['name'],
        updated = DateTime.parse(data['updated']),
        created = DateTime.parse(data['created']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'file': path,
        'updated': updated.toString(),
        'created': created.toString()
      };

  Future<void> load() async {
    if (loaded) {
      return;
    }

    final file = File(path);
    final json = await file.readAsString();

    text = Document.fromJson(jsonDecode(json));

    loaded = false;
    return;
  }

  Future<bool> exist() async {
    final file = File(path);

    return await file.exists();
  }

  Future<void> delete() async {
    final file = File(path);

    await file.delete();
  }

  Future<void> update() async {
    final file = File(path);

    updated = DateTime.now();
    await file.writeAsString(jsonEncode(text.toDelta().toJson()));
    return;
  }
}
