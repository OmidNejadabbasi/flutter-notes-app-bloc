

import 'package:floor/floor.dart';
import 'package:tak_note/models/note.dart';

@dao
abstract class NoteDAO {

  @Query("SELECT * FROM Note")
  Future<List<Note>> getAllNotes();

  @Query("SELECT * FROM Note")
  Stream<List<Note>> getAllNotesAsStream();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertNote(Note note);

  @Query("DELETE FROM Note WHERE id=:noteId")
  Future<void> deleteNote(int noteId);
}