part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

class NoteInactive extends NoteState {}

class NoteLoading extends NoteState {}

class NoteCreated extends NoteState {
  final int index;

  const NoteCreated(this.index);

  @override
  List<Object> get props => [index];
}
