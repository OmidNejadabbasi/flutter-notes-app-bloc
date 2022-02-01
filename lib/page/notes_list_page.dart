import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:tak_note/bloc/events/note_event.dart';
import 'package:tak_note/bloc/notes_list_bloc.dart';
import 'package:tak_note/main.dart';
import 'package:tak_note/models/note.dart';

class NotesListPage extends StatelessWidget {
  NotesListPage({Key? key}) : super(key: key);

  NotesListBloc? notesListBloc = null;

  @override
  Widget build(BuildContext context) {
    notesListBloc = AppContainer.blocProviderOf(context).notesListBloc;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('All Notes'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Note>>(
              stream: notesListBloc?.notesListStream,
              initialData: const [],
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildNoteListItem(snapshot.data![index], context);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/create_note');
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget buildNoteListItem(Note note, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      margin: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      note.title,
                      style: const TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 66, 66, 66),
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                      child: Text(
                        _parseHtmlString(note.content) ?? "",
                        maxLines: 1,
                        style: const TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 150, 150, 150),
                        ),
                      ),
                    ),
                    Text(
                      DateFormat.yMMMMd('en_US').format(note.updatedAt),
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'OpenSans',
                        color: Color.fromARGB(255, 180, 180, 180),
                      ),
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
              Material(
                clipBehavior: Clip.hardEdge,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: IconButton(
                  iconSize: 18,
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    notesListBloc?.noteEventSink
                        .add(DeleteNote(noteId: note.id ?? -1));
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

String? _parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String? parsedString = parse(document.body?.text).documentElement?.text;

  return parsedString;
}
