import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as editor;
import 'package:note_app_desktop/bloc/note_bloc.dart';
import 'package:note_app_desktop/src/components/editor.dart';

import '../../class/note.dart';

class NoteUpdate extends StatefulWidget {
  NoteUpdate({Key? key, required this.note, required this.index})
      : super(key: key);

  int index;
  Note note;

  @override
  State<NoteUpdate> createState() => _NoteUpdateState();
}

class _NoteUpdateState extends State<NoteUpdate> {
  ScrollController scroll = ScrollController();

  TextEditingController title = TextEditingController();
  editor.QuillController text = editor.QuillController(
    document: editor.Document(),
    selection: const TextSelection.collapsed(offset: 0),
  );

  @override
  void initState() {
    text = editor.QuillController(
      document: editor.Document.fromDelta(widget.note.text.toDelta()),
      selection: const TextSelection.collapsed(offset: 0),
    );

    title = TextEditingController(text: widget.note.name);
    scroll = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    text.dispose();
    title.dispose();
    scroll.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant NoteUpdate oldWidget) {
    title.text = widget.note.name;
    text.dispose();

    text = editor.QuillController(
      document: editor.Document.fromDelta(widget.note.text.toDelta()),
      selection: const TextSelection.collapsed(offset: 0),
    );

    super.didUpdateWidget(oldWidget);
  }

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
                quill: text,
                scroll: scroll,
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
                  onPressed: () => onSavePressed(context),
                  icon: const Icon(Icons.save),
                  label: const Text('Sauvegarder'),
                );
              } else {
                return const FloatingActionButton(
                  disabledElevation: 0,
                  isExtended: true,
                  onPressed: null,
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  void onSavePressed(BuildContext context) {
    widget.note.text = text.document;
    BlocProvider.of<NoteBloc>(context)
        .add(NoteUpdateRequested(widget.note, widget.index));
  }
}
