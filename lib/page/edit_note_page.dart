
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:tak_note/bloc/edit_note_bloc.dart';
import 'package:tak_note/bloc/events/note_event.dart';
import 'package:tak_note/main.dart';

class EditNotePage extends StatelessWidget {
  EditNotePage({Key? key, required this.editNoteBloc}) : super(key: key);

  final HtmlEditorController _controller = HtmlEditorController();

  final EditNoteBloc editNoteBloc;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('New note'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  editNoteBloc.noteEventSink.add(NoteTitleChanged(value));
                },
                style: Theme
                    .of(context)
                    .textTheme
                    .subtitle1,
                decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: Theme
                        .of(context)
                        .textTheme
                        .subtitle2),
              ),
              const SizedBox(
                height: 20,
              ),
              HtmlEditor(
                controller: _controller,
                htmlEditorOptions: const HtmlEditorOptions(
                  hint: "Content",
                  inputType: HtmlInputType.text,
                ),
                htmlToolbarOptions:
                const HtmlToolbarOptions(defaultToolbarButtons: [
                  FontButtons(),
                  FontSettingButtons(),
                  StyleButtons(),
                  ListButtons(),
                  ParagraphButtons(),
                ]),
              ),
              ElevatedButton(
                onPressed: () async {
                  // send create note signal
                  editNoteBloc.noteEventSink
                      .add(NoteContentChanged(await _controller.getText()));
                  editNoteBloc.noteEventSink.add(SaveNote());
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
