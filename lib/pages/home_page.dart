import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/boxes/boxes.dart';
import 'package:notes_app/models/notes_model.dart';
import 'package:notes_app/utils/dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final titleController = TextEditingController();
  final descreptionController = TextEditingController();

  void onSave() {
    // save the data
    final data = NotesModel(
      title: titleController.text,
      description: descreptionController.text,
    );
    final box = Boxes.getNotes();
    box.add(data);
    data.save();
    titleController.clear();
    descreptionController.clear();
    // close the dialog
    Navigator.of(context).pop();
  }

  void editNote(NotesModel notesModel, String title, String description) {
    // edit notes
    final box = Boxes.getNotes();
    notesModel.title = title;
    notesModel.description = description;
    box.put(notesModel.key, notesModel);
    notesModel.save();
    titleController.clear();
    descreptionController.clear();
    // close the dialog
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes App'),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return DialogBox(
                titleController: titleController,
                descreptionController: descreptionController,
                onSave: onSave,
                onCancel: () => Navigator.of(context).pop(),
                text: 'Add Note',
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: Boxes.getNotes().listenable(),
        builder: (context, Box<NotesModel> box, _) {
          final notes = box.values.toList().cast<NotesModel>();
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Dismissible(
                key: ValueKey(note),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: AlignmentDirectional.centerEnd,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) {
                  note.delete();
                },
                child: ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.description),
                  trailing: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return DialogBox(
                            titleController: titleController
                              ..text = note.title.toString(),
                            descreptionController: descreptionController
                              ..text = note.description.toString(),
                            onSave: () {
                              editNote(
                                note,
                                titleController.text,
                                descreptionController.text,
                              );
                            },
                            onCancel: () => Navigator.of(context).pop(),
                            text: 'Edit Note',
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
