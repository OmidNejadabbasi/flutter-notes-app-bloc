
import 'package:tak_note/db/database.dart';
import 'package:tak_note/models/note.dart';
import 'package:tak_note/models/note_tag.dart';

class NoteService {
  late AppDatabase _db;
  NoteService(AppDatabase db) {
    _db = db;
  }

  Future<int> saveNote(Note note){
    return _db.noteDAO.insertNote(note);
  }

  Future<List<Note>> getAllNotes() {
    return _db.noteDAO.getAllNotes();
  }

  Stream<List<Note>> getAllNotesAsStream() {
    return _db.noteDAO.getAllNotesAsStream();
  }

  void deleteNote(int noteId) {
    _db.noteDAO.deleteNote(noteId);
  }

  Future<int> addTagToNote(int noteId, int tagId){
    return _db.noteTagDAO.addTagToNote(NoteTag(noteId, tagId, null));
  }

}