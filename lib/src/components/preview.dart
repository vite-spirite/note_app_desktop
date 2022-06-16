import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:note_app_desktop/class/note.dart';

class NotePreview extends StatelessWidget {
  final Note note;
  final VoidCallback? onTap;
  const NotePreview({Key? key, required this.note, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Card(
          child: SizedBox(
        height: 400.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: QuillEditor.basic(
                  controller: QuillController(
                    document: note.text,
                    selection: const TextSelection.collapsed(offset: 0),
                  ),
                  readOnly: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                note.name,
                style: const TextStyle(fontSize: 24.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.add),
                      Text(note.createdUTCDate)
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.edit),
                      Text(note.updatedUTCDate)
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
