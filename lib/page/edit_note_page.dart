import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:tak_note/bloc/edit_note_bloc.dart';
import 'package:tak_note/bloc/events/add_tag_to_note_event.dart';
import 'package:tak_note/bloc/events/note_event.dart';
import 'package:tak_note/models/tag.dart';

class EditNotePage extends StatefulWidget {
  EditNotePage({Key? key, required this.editNoteBloc}) : super(key: key);

  final EditNoteBloc editNoteBloc;

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  final HtmlEditorController _controller = HtmlEditorController();

  List<Tag> tags = <Tag>[];

  @override
  Widget build(BuildContext context) {
    widget.editNoteBloc.tagsStream.listen((newTags) {
      tags = newTags;
    });
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
                  widget.editNoteBloc.noteEventSink
                      .add(NoteTitleChanged(value));
                },
                style: Theme.of(context).textTheme.subtitle1,
                decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: Theme.of(context).textTheme.subtitle2),
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
              ChipsInput(
                chipBuilder: (context, state, dynamic data) {
                  widget.editNoteBloc.addTagToNote(AddTagToNote(data.id));
                  return InputChip(
                    key: ObjectKey(data.name),
                    label: Text(data.name),
                    onDeleted: () => state.deleteChip(data.name),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  );
                },
                suggestionBuilder: (context, state, dynamic data) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    key: ObjectKey(data.name),
                    child: TextButton(

                      child: Text(data.name),
                      onPressed: () {
                        state.selectSuggestion(data);
                      },
                    ),
                   
                  );
                },
                findSuggestions: (query) {
                  if (query.isNotEmpty) {
                    return tags
                        .where((element) => element.name
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                        .toList();
                  }
                  return tags;
                },
                onChanged: (value) {},
              ),
              ElevatedButton(
                onPressed: () async {
                  // send create note signal
                  widget.editNoteBloc.noteEventSink
                      .add(NoteContentChanged(await _controller.getText()));
                  widget.editNoteBloc.noteEventSink.add(SaveNote());
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
