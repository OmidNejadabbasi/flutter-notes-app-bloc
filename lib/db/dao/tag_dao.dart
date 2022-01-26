

import 'package:floor/floor.dart';
import 'package:tak_note/models/tag.dart';

@dao
abstract class TagDAO {

  @Query("SELECT * FROM Tag")
  Stream<Tag?> getAllTagsAsStream();

}