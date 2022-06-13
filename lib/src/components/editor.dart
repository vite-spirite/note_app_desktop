import "package:flutter/material.dart";
import "package:flutter_quill/flutter_quill.dart" as editor;

class MyEditor extends StatelessWidget {
  final ScrollController scroll;
  final editor.QuillController quill;

  const MyEditor({Key? key, required this.scroll, required this.quill})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        editor.QuillToolbar.basic(
          toolbarSectionSpacing: 0,
          toolbarIconAlignment: WrapAlignment.start,
          controller: quill,
          locale: const Locale('fr'),
          showAlignmentButtons: true,
        ),
        Expanded(
          child: editor.QuillEditor(
            controller: quill,
            readOnly: false,
            focusNode: FocusNode(),
            scrollable: true,
            scrollController: scroll,
            autoFocus: false,
            padding: const EdgeInsets.all(8.0),
            expands: true,
            placeholder: "Écrivez une note...",
          ),
        ),
      ],
    );
  }
}
