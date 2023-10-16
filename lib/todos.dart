import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseReference _database = FirebaseDatabase.instance.reference().child('todos');
  final TextEditingController _todoController = TextEditingController();
  List<String> todos = [];

  @override
  void initState() {
    super.initState();
    _database.onChildAdded.listen((event) {
      setState(() {
       // todos.add(event.snapshot.value);
      });
    });
  }

  void _addTodo() {
    String todo = _todoController.text.trim();
    if (todo.isNotEmpty) {
      _database.push().set(todo);
      _todoController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _todoController,
                    decoration: const InputDecoration(labelText: 'Add a To-Do'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addTodo,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(todos[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
