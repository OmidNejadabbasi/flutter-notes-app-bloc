
import 'package:floor/floor.dart';

@DatabaseView(
    """SELECT tag_id, c.count FROM Tag 
LEFT JOIN (SELECT COUNT(*) count, tag_id FROM NoteTag GROUP BY tag_id) c
ON Tag.tag_id=c.tag_id""", viewName: 'tagNoteCount')
class TagNoteCount {

  @ColumnInfo(name: "Tag.tag_id")
  final int tagID;

  @ColumnInfo(name: 'c.count')
  final int noteCount;

  TagNoteCount(this.tagID, this.noteCount);
}