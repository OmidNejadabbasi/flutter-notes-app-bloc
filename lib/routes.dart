import 'package:flutter/material.dart';
import 'package:tak_note/bloc/edit_note_bloc.dart';
import 'package:tak_note/db/database.dart';
import 'package:tak_note/models/note.dart';
import 'package:tak_note/page/edit_note_page.dart';
import 'package:tak_note/page/notes_list_page.dart';
import 'package:tak_note/page/tags_list_page.dart';
import 'package:tak_note/service/note_service.dart';
import 'package:tak_note/service/tags_service.dart';

class AppConfiguration {
  late NoteService noteService;

  late TagsService tagsService;

  initApp() async {
    final db = await $FloorAppDatabase.databaseBuilder('notedb.db').build();
    noteService = NoteService(db);
    tagsService = TagsService(db);
  }

  Route? onGenerateRoute(RouteSettings settings) {
    Map<String, MaterialPageRoute> routeMap = {
      "/edit_note": MaterialPageRoute(
          builder: (context) => EditNotePage(
                editNoteBloc: EditNoteBloc(
                  noteService,
                  tagsService,
                  settings.arguments as Note,
                ),
              )),
      "/all_notes": MaterialPageRoute(builder: (context) => NotesListPage()),
      "/tags": MaterialPageRoute(builder: (context) => TagsListPage()),
    };
    return routeMap[settings.name];
  }

  static final AppConfiguration _appConfiguration = AppConfiguration._internal();
  factory AppConfiguration() {
    return _appConfiguration;
  }

  AppConfiguration._internal();
}
