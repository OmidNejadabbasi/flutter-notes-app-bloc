import 'package:flutter/material.dart';
import 'package:tak_note/bloc/create_note_bloc.dart';
import 'package:tak_note/db/database.dart';
import 'package:tak_note/routes.dart';
import 'package:tak_note/service/note_service.dart';
import 'package:tak_note/theme.dart';

import 'bloc/notes_list_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = await $FloorAppDatabase.databaseBuilder('notedb.db').build();
  final noteService = NoteService(db);
  final blocProvider =
      BlocProvider(createNoteBloc: CreateNoteBloc(noteService),
      notesListBloc: NotesListBloc(noteService: noteService));

  runApp(AppContainer(blocProvider: blocProvider, child: TakeNoteApp()));
}

class TakeNoteApp extends StatelessWidget {
  const TakeNoteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme(),
      initialRoute: '/all_notes',
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}

class AppContainer extends StatefulWidget {
  final Widget child;
  final BlocProvider blocProvider;

  const AppContainer(
      {Key? key, required this.blocProvider, required this.child})
      : super(key: key);

  @override
  AppState createState() => AppState();

  static BlocProvider blocProviderOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedAppState>()!
        .blocProvider;
  }
}

class AppState extends State<AppContainer> {
  @override
  Widget build(BuildContext context) {
    return _InheritedAppState(
      blocProvider: widget.blocProvider,
      child: widget.child,
    );
  }
}

class _InheritedAppState extends InheritedWidget {
  final BlocProvider blocProvider;

  const _InheritedAppState({
    Key? key,
    required this.blocProvider,
    child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedAppState oldWidget) {
    return blocProvider != oldWidget.blocProvider;
  }
}

class BlocProvider {
  final CreateNoteBloc createNoteBloc;
  final NotesListBloc notesListBloc;

  BlocProvider({required this.notesListBloc, required this.createNoteBloc});
}
