import 'package:bacala_assignment_3/model/todo_model.dart';
import 'package:flutter/material.dart';
import '../sqliteService/sqliteService.dart';


class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<StatefulWidget> createState() {
    return AddTodoState();
  }
}
class AddTodoState extends State {
  final _formKey = GlobalKey<FormState>();

  var body = TextEditingController();
  var title = TextEditingController();
  var databaseProvider = DatabaseProvider();
  Todo? todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Todo",
          style: TextStyle(
              fontWeight: FontWeight.w900, fontSize: 20, color: Colors.white),
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
                              ElevatedButton(
                                child: const Text(
                                  "Add Task",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                                onPressed: () {
                                  addProduct();
                                },
                              )
                            ])),
                  ])
          )
      ),
    );
  }


  void addProduct() async {
    var result = await databaseProvider.insert(Todo.withId(
      title: title.text,
      body: body.text,
    ));
    Navigator.pop(context, true);
  }
}
