import 'package:floor/floor.dart';
import 'package:tak_note/models/note.dart';
import 'package:tak_note/models/tag.dart';

@Entity(foreignKeys: [
  ForeignKey(
    childColumns: ['note_id'],
    parentColumns: ['id'],
    entity: Note,
  ),
  ForeignKey(
    childColumns: ['tag_id'],
    parentColumns: ['id'],
    entity: Tag,
  )
])
class NoteTag {
  @PrimaryKey(autoGenerate: true)
  final int id;

  @ColumnInfo(name: "note_id")
  final int noteId;

  @ColumnInfo(name: "tag_id")
  final int tagId;

  NoteTag(this.noteId, this.tagId, this.id);
}
