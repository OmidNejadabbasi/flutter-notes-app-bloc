import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tak_note/bloc/events/create_note.dart';
import 'package:tak_note/main.dart';

class CreateNotePage extends StatelessWidget {
  const CreateNotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final createNoteBloc = AppContainer.blocProviderOf(context).createNoteBloc;
    return Scaffold(
      appBar: AppBar(
        title: const Text('New note'),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  createNoteBloc.noteEventSink.add(NoteTitleChanged(value));
                },
                style: Theme.of(context).textTheme.subtitle1,
                decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: Theme.of(context).textTheme.headline6),
              ),
              TextFormField(
                onChanged: (value) {
                  createNoteBloc.noteEventSink.add(NoteContentChanged(value));
                },
                style: Theme.of(context).textTheme.subtitle1,
                decoration: InputDecoration(
                    hintText: 'Content',
                    hintStyle: Theme.of(context).textTheme.headline6),
                maxLines: 1000,
                minLines: 5,
              ),
              ElevatedButton(
                onPressed: () {
                  // send create note signal
                  createNoteBloc.noteEventSink.add(CreateNote());
                },
                child: const Text('Save'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
