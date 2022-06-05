import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<Directory> getLocalDir() async {
  return await getApplicationDocumentsDirectory();
}

Future<String> getLocalPath() async {
  Directory dir = await getLocalDir();
  return dir.path;
}

Future<File> getStoreFile() async {
  final path = await getLocalPath();
  return File('$path/store.json');
}