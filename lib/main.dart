import 'package:flutter/material.dart';
import 'package:tak_note/bloc/edit_note_bloc.dart';
import 'package:tak_note/bloc/tags_list_bloc.dart';
import 'package:tak_note/db/database.dart';
import 'package:tak_note/routes.dart';
import 'package:tak_note/service/note_service.dart';
import 'package:tak_note/service/tags_service.dart';
import 'package:tak_note/theme.dart';

import 'bloc/notes_list_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppConfiguration config = AppConfiguration();
  await config.initApp();

  runApp(TakeNoteApp(appConfiguration: config,));
}

class TakeNoteApp extends StatelessWidget {
  TakeNoteApp({Key? key, required this.appConfiguration}) : super(key: key);

  final AppConfiguration appConfiguration;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme(),
      initialRoute: '/all_notes',
      onGenerateRoute: appConfiguration.onGenerateRoute,
    );
  }
}

