
import 'package:tak_note/db/database.dart';

class NoteService {
  late AppDatabase _db;
  NoteService(AppDatabase db) {
    _db = db;
  }
}