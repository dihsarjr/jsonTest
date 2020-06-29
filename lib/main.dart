import 'dart:async';
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
  Future<List<Todo>> _getTodo() async {
    var data = await http.get("https://jsonplaceholder.typicode.com/todos");
    var jsonData = json.decode(data.body);
    List<Todo> todo = [];
    for (var u in jsonData) {
      Todo todo = Todo(u["index"], u["title"]);
    }
    print(todo.length.toString());
    return todo;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Json'),
        ),
        body: Container(
          child: FutureBuilder(
              future: _getTodo(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return snapshot.data == null
                    ? Center(
                        child: Container(
                          height: 300,
                          color: Colors.black,
                        ),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              child: Text(
                            snapshot.data[index].index.toString(),
                          ));
                        });
              }),
        ),
      ),
    );
  }
}

class Todo {
  final int index;
  final String title;

  Todo(this.index, this.title);
}
