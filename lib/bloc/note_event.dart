part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class NoteUpdateRequested extends NoteEvent {
  final Note note;
  final int index;

  const NoteUpdateRequested(this.note, this.index);

  @override
  List<Object> get props => [];
}

class NoteDestroyRequested extends NoteEvent {
  final Note note;

  const NoteDestroyRequested(this.note);

  @override
  List<Object> get props => [];
}

class NoteCreateRequested extends NoteEvent {
  final String name;
  final String text;

  const NoteCreateRequested(this.name, this.text);

  @override
  List<Object> get props => [name, text];
}
