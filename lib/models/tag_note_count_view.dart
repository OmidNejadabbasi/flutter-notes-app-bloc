import 'package:floor/floor.dart';

@DatabaseView(
    """SELECT Tag.id AS tag_id, IFNULL(c.count, 0) AS noteCount FROM Tag 
LEFT JOIN (SELECT COUNT(*) count, tag_id FROM NoteTag GROUP BY tag_id) c
ON Tag.id=c.tag_id""",
    viewName: 'TagNoteCount')
class TagNoteCount {
  @ColumnInfo(name: "tag_id")
  final int tagID;

  @ColumnInfo(name: 'noteCount')
  final int noteCount;

  TagNoteCount(this.tagID, this.noteCount);
}
