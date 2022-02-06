import 'package:flutter/material.dart';
import 'package:tak_note/page/create_note_page.dart';
import 'package:tak_note/page/notes_list_page.dart';
import 'package:tak_note/page/tags_list_page.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    Map<String, MaterialPageRoute> routeMap = {
      "/create_note": MaterialPageRoute(builder: (context) => CreateNotePage()),
      "/all_notes": MaterialPageRoute(builder: (context) => NotesListPage()),
      "/tags": MaterialPageRoute(builder: (context) => TagsListPage()),
    };
    return routeMap[settings.name];
  }
}
