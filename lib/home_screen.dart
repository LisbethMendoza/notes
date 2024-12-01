import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notes/login_screen.dart';
import 'package:notes/model/todo_model.dart';
import 'package:notes/services/auth_services.dart';
import 'package:notes/services/database_services.dart';
import 'package:notes/widgets/completed_widget.dart';
import 'package:notes/widgets/pending_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _buttonIndex = 0;
  final _widgets = [
    //PEDING
    PendingWidget(),

    //Completed
    CompletedWidget(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(246, 31, 1, 1),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(246, 31, 1, 1),
        foregroundColor: Colors.white,
        title: Text("Notas"),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService().signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      setState(() {
                        _buttonIndex = 0;
                      });
                    },
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2.2,
                        decoration: BoxDecoration(
                          color:
                              _buttonIndex == 0 ? Colors.indigo : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: _buttonIndex == 0 ? 16 : 14,
                            fontWeight: FontWeight.w500,
                            color: _buttonIndex == 0
                                ? Colors.white
                                : Colors.black38,
                          ),
                        )))),
                InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      setState(() {
                        _buttonIndex = 1;
                      });
                    },
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2.2,
                        decoration: BoxDecoration(
                          color:
                              _buttonIndex == 1 ? Colors.indigo : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: Text(
                          "Completed",
                          style: TextStyle(
                            fontSize: _buttonIndex == 1 ? 16 : 14,
                            fontWeight: FontWeight.w500,
                            color: _buttonIndex == 1
                                ? Colors.white
                                : Colors.black38,
                          ),
                        )))),
              ],
            ),
            SizedBox(height: 30),
            _widgets[_buttonIndex],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: () {
            _showTaskDialog(context);
          }),
    );
  }

  void _showTaskDialog(BuildContext context, {Todo? todo}) {
    final TextEditingController _titleController =
        TextEditingController(text: todo?.title);
    final TextEditingController _descriptionController =
        TextEditingController(text: todo?.description);
    final DatabaseService _databaseService = DatabaseService();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            todo == null ? "Add Task" : "Edit Note",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          content: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: "Title",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),

            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  if (todo == null) {
                    await _databaseService.addTodoTask(
                        _titleController.text, _descriptionController.text);
                  } else {
                    await _databaseService.updateTodo(todo.id,
                        _titleController.text, _descriptionController.text);
                  }
                  Navigator.pop(context);
                },
                child: Text(todo == null ? "Add" : "Update" ),
              ),
          ],
        );
      },
    );
  }
}
