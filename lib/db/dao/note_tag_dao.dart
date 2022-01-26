


import 'package:floor/floor.dart';
import 'package:tak_note/models/note_tag.dart';


@dao
abstract class NoteTagDAO {

  @Query("SELECT * FROM NoteTag WHERE note_id = :noteId")
  Future<List<NoteTag>> getTagsForNote(int noteId);

  @Query("SELECT * FROM NoteTag WHERE tag_id= :tagId")
  Future<List<NoteTag>> getNotesForTag(int tagId);


}