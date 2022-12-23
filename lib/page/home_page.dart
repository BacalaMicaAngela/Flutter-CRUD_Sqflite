import 'package:bacala_assignment_3/page/update_todo_page.dart';
import 'package:bacala_assignment_3/sqliteService/sqliteService.dart';
import 'package:flutter/material.dart';
import 'add_todo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var databaseProvider = DatabaseProvider();
  List todos = [];
  int todoCount = 0;


  @override
  void initState() {
    databaseProvider.getTodos();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo App",
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20,
              color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: todoCount,
          itemBuilder: (BuildContext context, int position) {
            return Card(
                  color: Colors.white30,
                  elevation: 2.0,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.black12,
                      child: Icon(Icons.task),
                    ),
                    title: Text(
                      this.todos[position].title,
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white),
                    ),
                    subtitle: Text(
                      this.todos[position].body,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white),
                    ),
                    onTap: () {
                      goToDetail(this.todos[position]);
                    },
                  ),
                );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool result = await Navigator.push(
              context,
              MaterialPageRoute
            (builder: (context) => const AddTodo()));
          if (result != null) {
            if (result) {
              getTodo();
            }
          }
        },
        child: Icon(Icons.add),
        tooltip: "Add Task",
      ),
    );
  }

  void getTodo() async {
    var todosFuture = databaseProvider.getTodos();
    todosFuture.then((data) {
      setState(() {
        this.todos = data;
        todoCount = data.length;
      });
    });
  }

  void goToDetail(todo) async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => UpdateTodo(todo)));
    if (result != null) {
      if (result) {
        getTodo();
      }
    }
  }
}