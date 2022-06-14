import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app_desktop/bloc/note_bloc.dart';
import 'package:note_app_desktop/src/components/navigation_item.dart';

class Navigation extends StatelessWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (_, __) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ...listAllDocuments(context),
            const Spacer(),
            NavigationItem(
              title: "+ Nouvelle note",
              onPressed: () => context.go('/new'),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> listAllDocuments(BuildContext context) {
    final bloc = BlocProvider.of<NoteBloc>(context);
    final notes = bloc.repository.notes;

    List<Widget> items = [];

    for (int i = 0; i < notes.length; i++) {
      items.add(NavigationItem(
          title: notes[i].name, onPressed: () => context.go('/index/$i')));
    }

    return items;
  }
}
