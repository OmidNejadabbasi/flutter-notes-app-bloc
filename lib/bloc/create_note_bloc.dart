

import 'dart:async';

import 'package:tak_note/bloc/events/create_note.dart';
import 'package:tak_note/bloc/form_status.dart';

class CreateNoteBloc {

  StreamController<NoteEvent> noteEvent = StreamController();

  StreamController<FormSubmissionStatus> noteState = StreamController();

  CreateNoteBloc(NoteService _noteService) {
    noteEvent.stream.listen(_mapNoteEventToFormState);
  }




  void _mapNoteEventToFormState(NoteEvent event) {
    if (event is CreateNote) {
      noteState.sink.add(FormSubmitting());


    }
  }
}