
import 'package:tak_note/models/note.dart';

abstract class NoteEvent {}

class NoteTitleChanged extends NoteEvent {

  final String noteTitle;

  NoteTitleChanged(this.noteTitle);
}

class NoteContentChanged extends NoteEvent{
  final String noteContent;

  NoteContentChanged(this.noteContent);
}

class CreateNote extends NoteEvent {
}

