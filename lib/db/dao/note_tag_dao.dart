


import 'package:floor/floor.dart';
import 'package:tak_note/models/note.dart';
import 'package:tak_note/models/tag.dart';

@dao
abstract class NoteTagDAO {

  @Query("SELECT * FROM NoteTag WHERE note_id = :noteId")
  Future<List<Tag>> getTagsForNote(int noteId);

  @Query("SELECT * FROM NoteTag WHERE tag_id= :tagId")
  Future<List<Note>> getNotesForTag(int tagId);


}