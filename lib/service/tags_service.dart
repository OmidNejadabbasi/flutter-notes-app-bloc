

import 'package:tak_note/db/database.dart';
import 'package:tak_note/models/tag.dart';

class TagsService {

  AppDatabase _db;

  TagsService(this._db);

  Stream<List<Tag>> getAllTags() {
    return _db.tagDAO.getAllTagsAsStream();
  }

  Future<void> insertTag(Tag tag) async {
    await _db.tagDAO.insertTag(tag);
  }

}