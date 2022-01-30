

import 'package:flutter/material.dart';
import 'package:tak_note/bloc/events/create_note.dart';
import 'package:tak_note/page/create_note_page.dart';


class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch(settings.name) {
      case "/create_note":
        return MaterialPageRoute(builder: (context) => const CreateNotePage(),);
    }
  }
}