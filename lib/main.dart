import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hive_db/todo.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  //Register the Adapter
  Hive.registerAdapter(TodoAdapter());
  //Open a new box with todo data type
  await Hive.openBox<Todo>('todo');
  await Hive.openBox('friend');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  var title;

  MyHomePage({super.key, this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String? name;

  Box friendbox = Hive.box('friend');

  addFriend() async {
    await friendbox.put('name','Bill Gates');
  }

  getFriend() async {
    setState(() {
      name = friendbox.get('name');
    });
  }

  updateFriend() async {
      await friendbox.put('name', 'Mark');
  }

  deleteFriend() async {
    await friendbox.delete('name');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$name"),
            ElevatedButton(
              onPressed: () {addFriend();},
              child: const Text("Create"),
            ),
            ElevatedButton(
              onPressed: () {getFriend();},
              child: const Text("Read"),
            ),
            ElevatedButton(
              onPressed: () {updateFriend();},
              child: const Text("Update"),
            ),
            ElevatedButton(
              onPressed: () {deleteFriend();},
              child: const Text("Delete"),
            )
          ],
        ),
      ),
    );
  }
}
