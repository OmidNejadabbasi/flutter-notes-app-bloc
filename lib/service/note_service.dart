
import 'package:tak_note/db/database.dart';
import 'package:tak_note/models/note.dart';

class NoteService {
  late AppDatabase _db;
  NoteService(AppDatabase db) {
    _db = db;
  }

  Future<void> saveNote(Note note){
    return _db.noteDAO.insertNote(note);
  }
}