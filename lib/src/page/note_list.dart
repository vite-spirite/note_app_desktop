import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app_desktop/bloc/note_bloc.dart';
import 'package:note_app_desktop/class/note.dart';
import 'package:note_app_desktop/src/components/preview.dart';

class NoteList extends StatelessWidget {
  final ScrollController _controller = ScrollController();

  NoteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NoteBloc bloc = BlocProvider.of<NoteBloc>(context);
    final List<Note> notes = bloc.repository.notes;

    return SingleChildScrollView(
      controller: _controller,
      child: _buildNoteList(context, notes),
    );
  }

  /*Widget _buildNoteList(BuildContext context, List<Note> notes) {
    return ListView.builder(
        shrinkWrap: true,
        controller: _controller,
        itemBuilder: (_, i) {
          return ListTile(
            hoverColor: Theme.of(context).primaryColor,
            title: Text(notes[i].name),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.calendar_month),
                    Text(
                        '${notes[i].created.day}/${notes[i].created.month}/${notes[i].created.year}'),
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: notes.length);
  }*/

  Widget _buildNoteList(BuildContext context, List<Note> notes) {
    List<Widget> previews = [];

    for (int i = 0; i < notes.length; i++) {
      previews.add(
          NotePreview(note: notes[i], onTap: () => context.go('/index/$i')));
    }

    return Wrap(
      spacing: 5.0,
      runSpacing: 5.0,
      children: [...previews],
    );
  }
}
