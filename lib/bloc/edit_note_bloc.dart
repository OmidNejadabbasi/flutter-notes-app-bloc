

import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tak_note/bloc/events/note_event.dart';
import 'package:tak_note/bloc/form_status.dart';
import 'package:tak_note/models/note.dart';
import 'package:tak_note/models/tag.dart';
import 'package:tak_note/service/note_service.dart';
import 'package:tak_note/service/tags_service.dart';

class EditNoteBloc {


  final StreamController<NoteEvent> _noteEvent = StreamController();
  Sink<NoteEvent> get noteEventSink => _noteEvent.sink;

  final StreamController<FormSubmissionStatus> _noteState = StreamController();
  Stream<FormSubmissionStatus> get noteFormState => _noteState.stream;

  final NoteService noteService;
  final TagsService tagsService;
  late Note _note;

  List<Tag> _tagList = <Tag>[];

  final BehaviorSubject<List<Tag>> _tagsStream = BehaviorSubject();
  Stream<List<Tag>> get tagsStream => _tagsStream.stream;

  EditNoteBloc(this.noteService, this.tagsService, Note note) {

    tagsService.getAllTags().listen((tagList) { 
      _tagList = tagList;
      _tagsStream.add(_tagList);
    });


    _noteEvent.stream.listen(_mapNoteEventToFormState);

    _note = note;

    
  }

  void addEvent(){

  }


  void _mapNoteEventToFormState(NoteEvent event) async {
    if (event is SaveNote) {
      _noteState.sink.add(FormSubmitting());
      try {
        await noteService.saveNote(_note);
        _noteState.sink.add(SubmissionSuccess());
      } catch (err) {
        _noteState.sink.add(SubmissionFailed(Exception("Form could not be submitted")));
      }
    } else if (event is NoteTitleChanged) {
      _note = Note(_note.id, event.noteTitle, _note.content, _note.createdAt, DateTime.now());
    } else if(event is NoteContentChanged) {
      _note = Note(_note.id, _note.title, event.noteContent, _note.createdAt, DateTime.now());
    }
  }
}