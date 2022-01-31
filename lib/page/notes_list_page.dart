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
                    return buildNoteListItem(snapshot.data![index]);
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

  Card buildNoteListItem(Note note) {
    return Card(
      elevation: 6,
      child: Column(
        children: [Text(note.title),
        Text(note.content),
        IconButton(
          onPressed: () {
            notesListBloc?.noteEventSink.add(DeleteNote(noteId: note.id ?? -1));
            print("delete noteId ${note.id}");
          },
          icon: const Icon(Icons.delete),
        ),
      ]
      ),
    );
  }
}
