

abstract class NoteEvent {}

class NoteTitleChanged extends NoteEvent {

  final String noteTitle;

  NoteTitleChanged(this.noteTitle);
}

class NoteContentChanged extends NoteEvent{
  final String noteContent;

  NoteContentChanged(this.noteContent);
}

class SaveNote extends NoteEvent {
}

class DeleteNote extends NoteEvent {
  int noteId;

  DeleteNote({required this.noteId});
}
