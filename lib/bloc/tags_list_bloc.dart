import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tak_note/models/tag.dart';
import 'package:tak_note/service/tags_service.dart';

class TagsListBloc {
  TagsService tagsService;

  TagsListBloc({required this.tagsService}) {
    tagsService.getAllTags().listen((tagsList) {
      debugPrint('New tag inserted to the database');
      _tagsStream.add(tagsList);
    });
  }

  final BehaviorSubject<List<Tag>> _tagsStream = BehaviorSubject();
  Stream<List<Tag>> get tagsStream => _tagsStream.stream;
  

  void saveTag(Tag newTag) {
     tagsService.insertTag(newTag);
  }


  void dispose() {
    _tagsStream.close();
  }
}
