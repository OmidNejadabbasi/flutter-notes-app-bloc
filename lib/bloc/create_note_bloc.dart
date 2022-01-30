

import 'dart:async';

import 'package:tak_note/bloc/events/create_note.dart';
import 'package:tak_note/bloc/form_status.dart';
import 'package:tak_note/models/note.dart';
import 'package:tak_note/service/note_service.dart';

class CreateNoteBloc {

  Note _note = Note(null, '', '', DateTime(1971), DateTime(1971));

  final StreamController<NoteEvent> _noteEvent = StreamController();
  Sink<NoteEvent> get noteEventSink => _noteEvent.sink;

  final StreamController<FormSubmissionStatus> _noteState = StreamController();
  Stream<FormSubmissionStatus> get noteFormState => _noteState.stream;

  final NoteService noteService;
  
  CreateNoteBloc(this.noteService) {
    _noteEvent.stream.listen(_mapNoteEventToFormState);


    
  }




  void _mapNoteEventToFormState(NoteEvent event) async {
    if (event is CreateNote) {
      _noteState.sink.add(FormSubmitting());
      try {
        await noteService.saveNote(_note);
        _noteState.sink.add(SubmissionSuccess());
      } catch (err) {
        _noteState.sink.add(SubmissionFailed(Exception("Form could not be submitted")));
      }
    } else if (event is NoteTitleChanged) {
      _note = Note(null, event.noteTitle, _note.content, _note.createdAt, DateTime.now());
    } else if(event is NoteContentChanged) {
      _note = Note(null, _note.title, event.noteContent, _note.createdAt, DateTime.now());
    }
  }
}