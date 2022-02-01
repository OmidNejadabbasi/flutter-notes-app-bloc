

import 'package:flutter/material.dart';
import 'package:tak_note/page/create_note_page.dart';
import 'package:tak_note/page/notes_list_page.dart';


class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch(settings.name) {
      case "/create_note":
        return MaterialPageRoute(builder: (context) => CreateNotePage(),);

      case "/all_notes":
        return MaterialPageRoute(builder: (context) => NotesListPage());
    }
  }
}