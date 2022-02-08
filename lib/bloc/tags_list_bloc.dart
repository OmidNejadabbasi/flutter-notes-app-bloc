import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tak_note/models/tag.dart';
import 'package:tak_note/models/tag_note_count_view.dart';
import 'package:tak_note/service/tags_service.dart';

class TagsListBloc {
  TagsService tagsService;

  List<Tag> _tagList = <Tag>[];
  List<TagNoteCount> _noteCount = [];
  TagsListBloc({required this.tagsService}) {
    tagsService.getAllTags().listen((tagsList) async {
      debugPrint('New tag inserted to the database');
      _tagList = tagsList;
      _noteCount = await tagsService.getNoteCountOfEachTag();
      _tagsStream.add(tagsList);
    });
  }

  final BehaviorSubject<List<Tag>> _tagsStream = BehaviorSubject();
  Stream<List<Tag>> get tagsStream => _tagsStream.stream;

  int getNoteCountForTag(int tagID) {
    int count = -1;
    for(TagNoteCount tnc in _noteCount){
      if (tnc.tagID == tagID)
        count = tnc.noteCount;
    }
    return count;
  }

  void saveTag(Tag newTag) {
     tagsService.insertTag(newTag);
  }


  void dispose() {
    _tagsStream.close();
  }
}
