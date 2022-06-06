import 'dart:io';

import 'package:flutter/material.dart';
import 'package:note_app_desktop/test/go_router_test.dart';
import 'package:note_app_desktop/utils/initialize_file_system.dart';
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    setWindowMinSize(const Size(800, 480));
    setWindowTitle('note app');
  }

  await initializeApp();

  runApp(MyApp());
}
