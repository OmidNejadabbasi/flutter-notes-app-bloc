
import 'package:floor/floor.dart';

@entity
class Tag {

  @PrimaryKey(autoGenerate: true)
  int? id;

  final String name;

  Tag(this.id, this.name);
}