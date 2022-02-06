import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tak_note/models/tag.dart';
import 'package:tak_note/service/tags_service.dart';

class TagsListBloc {
  TagsService tagsService;

  TagsListBloc({required this.tagsService}) {
    tagsService.getAllTags().listen((tagsList) {
      _tagsStream.add(tagsList);
    });
  }

  final BehaviorSubject<List<Tag>> _tagsStream = BehaviorSubject();
  Stream<List<Tag>> get tagsStream => _tagsStream.stream;
  



  void dispose() {
    _tagsStream.close();
  }
}
