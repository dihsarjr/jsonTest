import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Note> _notes = List<Note>();

  Future<List<Note>> fetchNote() async {
    var url = 'https://jsonplaceholder.typicode.com/todos';
    var response = await http.get(url);
    var note = List<Note>();
    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        note.add(Note.fromJson(noteJson));
      }
    }
    return note;
  }

  @override
  void initState() {
    fetchNote().then((value) {
      setState(() {
        _notes.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Json'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              color: Colors.red,
              elevation: 15,
              child: Column(
                children: <Widget>[
                  Text(
                    _notes[index].title,
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            );
          },
          itemCount: _notes.length,
        ),
      ),
    );
  }
}

class Note {
  String title;
  String text;

  Note(this.title, this.text);

  Note.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    text = json['text'];
  }
}
