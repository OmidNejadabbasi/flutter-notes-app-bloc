
import 'package:floor/floor.dart';

@entity
class Tag {

  @primaryKey
  final int id;

  final String name;

  Tag(this.id, this.name);
}