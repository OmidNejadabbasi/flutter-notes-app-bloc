import 'package:flutter/material.dart';
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
        border: Border.all(color: const Color.fromARGB(255, 43, 142, 142)),
        borderRadius: const BorderRadius.all(Radius.circular(9)),
      ),
      margin: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
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
                        fontFamily: 'Josefin',
                        fontSize: 26,
                        letterSpacing: -1,
                        color: Color.fromARGB(255, 66, 66, 66),
                      ),
                    ),
                    Text(
                      note.content,
                      style: const TextStyle(
                        fontFamily: 'Adanda',
                        color: Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
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
