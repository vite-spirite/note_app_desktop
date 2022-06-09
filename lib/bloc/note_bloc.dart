import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note_app_desktop/class/note.dart';
import 'package:note_app_desktop/class/note_store.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository repository;

  NoteBloc(this.repository) : super(NoteInactive()) {
    on<NoteCreateRequested>((event, emit) async {
      final tmp = await repository.create(event.name);
      await tmp.update(event.text);
    });
  }
}
