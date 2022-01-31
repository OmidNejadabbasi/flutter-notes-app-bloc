import 'dart:async';

import 'package:tak_note/bloc/events/note_event.dart';
import 'package:tak_note/bloc/form_status.dart';
import 'package:tak_note/models/note.dart';
import 'package:tak_note/service/note_service.dart';

class NotesListBloc {
  NoteService noteService;

  NotesListBloc({required this.noteService}) {
    noteService.getAllNotesAsStream().listen((event) {
      notesListStreamController.sink.add(event);
    });

    _noteEvent.stream.listen((event) {
      if (event is DeleteNote) {
        _handleDeleteEvent(event);
      }
    });
  }

  Future<void> _handleDeleteEvent(DeleteNote event) async {
    
    noteService.deleteNote(event.noteId);
    notesListStreamController.add(await noteService.getAllNotes());
          
  }

  final StreamController<List<Note>> notesListStreamController = StreamController();
  Stream<List<Note>> get notesListStream => notesListStreamController.stream;

  final StreamController<NoteEvent> _noteEvent = StreamController();

  Sink<NoteEvent> get noteEventSink => _noteEvent.sink;

  final StreamController<FormSubmissionStatus> _status = StreamController();

  Stream<FormSubmissionStatus> get statusStream => _status.stream;


}
