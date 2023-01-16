import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/models/notes_model.dart';
import 'package:notes_app/pages/home_page.dart';

void main() async {
  // init the hive
  await Hive.initFlutter();
  // register the adapter
  Hive.registerAdapter(NotesModelAdapter());
  // open the box
  await Hive.openBox<NotesModel>('notes');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
