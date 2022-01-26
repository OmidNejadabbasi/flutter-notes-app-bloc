

import 'package:floor/floor.dart';
import 'package:tak_note/models/note.dart';

@dao
abstract class NoteDAO {

  @Query("SELECT * FROM Note")
  Future<List<Note>> getAllNotes();


  @insert
  Future<void> insertNote(Note note);

}