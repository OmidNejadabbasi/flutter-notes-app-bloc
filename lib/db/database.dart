import 'dart:async';
import 'package:floor/floor.dart';
import 'package:tak_note/db/dao/note_dao.dart';
import 'package:tak_note/db/dao/note_tag_dao.dart';
import 'package:tak_note/db/dao/tag_dao.dart';
import 'package:tak_note/models/note.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:tak_note/models/note_tag.dart';
import 'package:tak_note/models/tag.dart';
import 'package:tak_note/models/tag_note_count_view.dart';


part 'database.g.dart';


@TypeConverters([
  DateTimeConverter
])
@Database(version: 1, entities: [Note, Tag, NoteTag], views: [TagNoteCount])
abstract class AppDatabase extends FloorDatabase {
  NoteDAO get noteDAO;
  TagDAO get tagDAO;
  NoteTagDAO get noteTagDAO;
}



// Type converters :

class DateTimeConverter extends TypeConverter<DateTime, int> {
  @override
  DateTime decode(int databaseValue) {
    return DateTime.fromMillisecondsSinceEpoch(databaseValue);
  }

  @override
  int encode(DateTime value) {
    return value.millisecondsSinceEpoch;
  }
}