import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tak_note/bloc/events/add_tag_to_note_event.dart';
import 'package:tak_note/bloc/events/note_event.dart';
import 'package:tak_note/bloc/form_status.dart';
import 'package:tak_note/models/note.dart';
import 'package:tak_note/models/tag.dart';
import 'package:tak_note/service/note_service.dart';
import 'package:tak_note/service/tags_service.dart';

class EditNoteBloc {
  final StreamController<NoteEvent> _noteEvent = StreamController();

  Sink<NoteEvent> get noteEventSink => _noteEvent.sink;

  final StreamController<AddTagToNote> _addTagToNoteStreamCtrl =
      StreamController();

  final StreamController<FormSubmissionStatus> _noteState = StreamController();

  Stream<FormSubmissionStatus> get noteFormState => _noteState.stream;

  final NoteService noteService;
  final TagsService tagsService;
  late Note _note;
  bool _isNoteSaved = true;

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
    if (_note.id == null) {
      _isNoteSaved = false;
      _setIdForNote();
    }
  }

  void addEvent() {}

  void _mapNoteEventToFormState(NoteEvent event) async {
    if (event is SaveNote) {
      _noteState.sink.add(FormSubmitting());
      try {
        await noteService.saveNote(_note);
        _noteState.sink.add(SubmissionSuccess());
        _isNoteSaved = true;
      } catch (err) {
        _noteState.sink
            .add(SubmissionFailed(Exception("Form could not be submitted")));
      }
    } else if (event is NoteTitleChanged) {
      _note = _note.copyWith(title: event.noteTitle, updatedAt: DateTime.now());
    } else if (event is NoteContentChanged) {
      _note =
          _note.copyWith(content: event.noteContent, updatedAt: DateTime.now());
    }
  }

  void addTagToNote(AddTagToNote addTagToNoteEvent) {
    noteService.addTagToNote(_note.id!, addTagToNoteEvent.tagId);
  }

  void _setIdForNote() async {
    int newNoteId = await noteService.saveNote(_note);
    _note = _note.copyWith(id: newNoteId);
  }

  void dispose(){
    if (!_isNoteSaved) {
      noteService.deleteNote(_note.id!);
    }
  }

}
