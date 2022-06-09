import 'dart:io';

class Note {
  String path;
  String name;
  DateTime updated;
  DateTime created;

  bool loaded = false;
  String text = "";

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
    text = await file.readAsString();

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

  Future<void> update(String text) async {
    final file = File(path);

    updated = DateTime.now();

    await file.writeAsString(text);
    return;
  }
}
