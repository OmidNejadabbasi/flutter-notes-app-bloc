import 'package:floor/floor.dart';


class Note {

  @PrimaryKey(autoGenerate: true)
  final int id;

  final String title;

  final String content;

  Note(this.id, this.title, this.content);


}