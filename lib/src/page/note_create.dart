import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_desktop/bloc/note_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as editor;
import 'package:note_app_desktop/src/components/editor.dart';

class NoteCreate extends StatelessWidget {
  final TextEditingController title = TextEditingController();
  final editor.QuillController _text = editor.QuillController(
    document: editor.Document(),
    selection: const TextSelection.collapsed(offset: 0),
  );
  final ScrollController _scroll = ScrollController();

  NoteCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: const TextStyle(fontSize: 24.0),
                controller: title,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Titre:',
                ),
              ),
            ),
            Expanded(
              child: MyEditor(
                quill: _text,
                scroll: _scroll,
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 15,
          right: 15,
          child: BlocBuilder<NoteBloc, NoteState>(
            builder: (context, state) {
              if (state is NoteInactive) {
                return FloatingActionButton.extended(
                  disabledElevation: 0,
                  isExtended: true,
                  onPressed: () => createNote(context),
                  icon: const Icon(Icons.save),
                  label: const Text('Sauvegarder'),
                );
              } else {
                return const FloatingActionButton(
                    disabledElevation: 0,
                    isExtended: true,
                    onPressed: null,
                    child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }

  /*Future<String?> _pickFileImpl(BuildContext context) async {
    if (!Platform.isLinux) {
      final result = await FilePicker.platform.pickFiles();
      print(result);
      return result?.files.single.path;
    } else {
      final result = await Process.run('zenity', ['--file-selection']);
      print(result.stdout);
      print(File(result.stdout).toString());
      return result.stdout.toString();
    }
  }

  Future<String> _onImagePickCallback(File file) async {
    // Copies the picked file from temporary cache to applications directory
    final appDocDir = await getApplicationDocumentsDirectory();
    await File("${appDocDir.path}/notes/${basename(file.path)}").create();
    final copiedFile =
        await file.copy('${appDocDir.path}/notes/${basename(file.path)}');
    return copiedFile.path.toString();
  }*/

  void createNote(BuildContext context) {
    return BlocProvider.of<NoteBloc>(context).add(NoteCreateRequested(
        title.text, jsonEncode(_text.document.toDelta().toJson())));
  }
}
