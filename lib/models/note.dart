import 'package:floor/floor.dart';


@entity
class Note {
  @PrimaryKey(autoGenerate: true)
  final int id;

  final String title;

  final String content;

  @ColumnInfo(name: "created_at")
  final DateTime createdAt;

  @ColumnInfo(name: "updated_at")
  final DateTime updatedAt;

  Note(this.id, this.title, this.content, this.createdAt, this.updatedAt);
}
