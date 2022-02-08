import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tak_note/bloc/tags_list_bloc.dart';
import 'package:tak_note/main.dart';
import 'package:tak_note/models/tag.dart';

class TagsListPage extends StatefulWidget {
  TagsListPage({Key? key}) : super(key: key);

  @override
  State<TagsListPage> createState() => _TagsListPageState();
}

class _TagsListPageState extends State<TagsListPage> {
  TagsListBloc? tagsListBloc;

  @override
  void dispose() {
    super.dispose();

    tagsListBloc?.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tagsListBloc = AppContainer.blocProviderOf(context).tagsListBloc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tags'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Tag>>(
              stream: tagsListBloc?.tagsStream,
              initialData: const [],
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    debugPrint("tag list builder called");
                    return buildTagListItem(snapshot.data![index], context);
                  },
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: Theme.of(context).primaryColor),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                "Add Tag",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'ZillaSlab',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 6,
              ),
            ],
          ),
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              Tag newTag = Tag(null, '');
              final tagFieldKey = GlobalKey<FormFieldState>();
              return Dialog(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        key: tagFieldKey,
                        onChanged: (value) {
                          newTag = Tag(null, value);
                        },
                        decoration: const InputDecoration(
                          labelText: 'Tag name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          return (value ?? "").isEmpty ? "Can't be null" : null;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('CANCEL'),
                          ),
                          TextButton(
                            onPressed: () {
                              if (tagFieldKey.currentState!.validate()) {
                                tagsListBloc?.saveTag(newTag);
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('SAVE'),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildTagListItem(Tag data, BuildContext context) {
    var noteCountForTag = tagsListBloc!.getNoteCountForTag(data.id!);
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Theme.of(context).primaryColor, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            data.name,
            style: const TextStyle(
              color: Color.fromARGB(255, 29, 29, 29),
              fontFamily: 'ZillaSlab',
              fontSize: 16,
            ),
          ),
          Text(
            noteCountForTag > 1
                ? "$noteCountForTag Notes"
                : "$noteCountForTag Note",
            style: const TextStyle(
              color: Colors.black54,
              fontFamily: 'Andada',
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
