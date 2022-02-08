

import 'package:floor/floor.dart';
import 'package:tak_note/models/tag.dart';
import 'package:tak_note/models/tag_note_count_view.dart';

@dao
abstract class TagDAO {

  @Query("SELECT * FROM Tag")
  Stream<List<Tag>> getAllTagsAsStream();

  @insert
  Future<void> insertTag(Tag tag);

  @Query('SELECT * FROM TagNoteCount')
  Future<List<TagNoteCount>> getNoteCountOfEachTag();

}