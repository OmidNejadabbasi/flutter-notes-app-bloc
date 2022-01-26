

import 'dart:async';

import 'package:tak_note/bloc/events/create_note.dart';
import 'package:tak_note/bloc/form_status.dart';
import 'package:tak_note/service/note_service.dart';

class CreateNoteBloc {

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
        await noteService.saveNote(event.note);
        _noteState.sink.add(SubmissionSuccess());
      } catch (err) {
        _noteState.sink.add(SubmissionFailed(Exception("Form could not be submitted")));
      }
    }
  }
}