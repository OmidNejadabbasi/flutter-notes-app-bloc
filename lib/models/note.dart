import 'package:floor/floor.dart';

@entity
class Note {
  @PrimaryKey(autoGenerate: true)
  int? id;

  final String title;

  final String content;

  @ColumnInfo(name: "created_at")
  final DateTime createdAt;

  @ColumnInfo(name: "updated_at")
  final DateTime updatedAt;

  Note(this.id, this.title, this.content, this.createdAt, this.updatedAt);

  Note copyWith({
    int? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Note(
      this.id ?? id,
      title ?? this.title,
      content ?? this.content,
      createdAt ?? this.createdAt,
      updatedAt ?? this.updatedAt,
    );
  }
}
