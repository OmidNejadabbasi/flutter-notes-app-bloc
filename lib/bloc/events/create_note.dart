
import 'package:tak_note/models/note.dart';

abstract class NoteEvent {}

class CreateNote extends NoteEvent {
  final Note note;

  CreateNote(this.note);
}

