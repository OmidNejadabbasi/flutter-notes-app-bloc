import 'dart:async';
import 'package:floor/floor.dart';
import 'package:tak_note/db/dao/note_dao.dart';
import 'package:tak_note/models/note.dart';
import 'package:sqflite/sqflite.dart' as sqflite;


part 'database.g.dart';


@Database(version: 1, entities: [Note])
abstract class AppDatabase extends FloorDatabase {
  NoteDAO get noteDAO;
}