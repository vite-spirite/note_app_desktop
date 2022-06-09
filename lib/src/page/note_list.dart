import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app_desktop/bloc/note_bloc.dart';
import 'package:note_app_desktop/class/note.dart';

class NoteList extends StatelessWidget {
  final ScrollController _controller = ScrollController();

  NoteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NoteBloc bloc = BlocProvider.of<NoteBloc>(context);
    final List<Note> notes = bloc.repository.notes;

    return Expanded(child: _buildNoteList(context, notes));
  }

  Widget _buildNoteList(BuildContext context, List<Note> notes) {
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
  }
}
