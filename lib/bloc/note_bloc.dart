import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:note_app_desktop/class/note.dart';
import 'package:note_app_desktop/class/note_store.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository repository;

  NoteBloc(this.repository) : super(NoteInactive()) {
    on<NoteCreateRequested>((event, emit) async {
      emit(NoteLoading());
      final tmp = await repository.create(event.name);

      tmp.text = Document.fromJson(jsonDecode(event.text));
      tmp.loaded = true;

      await tmp.update();
      await repository.update();
      emit(NoteInactive());
    });

    on<NoteUpdateRequested>((event, emit) async {
      emit(NoteLoading());
      await event.note.update();

      repository.notes[event.index] = event.note;
      await repository.update();

      emit(NoteInactive());
    });
  }
}
