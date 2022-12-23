import 'package:bacala_assignment_3/model/todo_model.dart';
import 'package:bacala_assignment_3/sqliteService/sqliteService.dart';
import 'package:flutter/material.dart';


class UpdateTodo extends StatefulWidget {
  final Todo todo;
  UpdateTodo(this.todo);

  @override
  State<StatefulWidget> createState() {
    return _TodoDetailState(todo);
  }
}


enum Options { delete, update }

class _TodoDetailState extends State {
  final Todo todo;
  _TodoDetailState(this.todo);

  final _formKey = GlobalKey<FormState>();

  var databaseProvider = DatabaseProvider();
  var title = TextEditingController();
  var body = TextEditingController();

  @override
  void initState() {
    title.text = todo.title.toString();
    body.text = todo.body.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Task",
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20,
              color: Colors.white),
        ),
        centerTitle: true,
      ),
        body: Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: SingleChildScrollView(
                child: Column(
                    children: [
                      Form(
                          key: _formKey,
                          child: Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                                    child: TextFormField(
                                      keyboardType: TextInputType.multiline,
                                      controller: title,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Title',
                                          labelText: 'Title'
                                      ),
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return " Enter Some Text ";
                                        }
                                        return null;
                                      },
                                    )),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                                  child: TextFormField(
                                    maxLines: null,
                                    minLines: 5,
                                    keyboardType: TextInputType.multiline,
                                    controller: body,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Write Some Notes here...',
                                        labelText:' Description'
                                    ),
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return " Enter Some Text ";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                 Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ElevatedButton(
                                        child: const Text(
                                          "Update",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                        onPressed: () async {
                                          await databaseProvider.update(Todo.withId(
                                            id: todo.id,
                                            title: title.text,
                                            body: body.text,
                                          ));
                                          Navigator.pop(context, true);
                                        },
                                      ),
                                      ElevatedButton(
                                        child: const Text(
                                          "Delete",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                        onPressed: () async {
                                          await databaseProvider.delete(todo.id);
                                          Navigator.pop(context, true);
                                        },
                                      ),
                                    ],
                                  ),
                              ])),
                    ])
            )
        ),
    );
  }
}