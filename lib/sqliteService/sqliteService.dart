import 'package:bacala_assignment_3/model/todo_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


//create a method to manipulate the data.
class DatabaseProvider {

  // to define the variables
  Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await initializedatabase();
    }
    return _database;
  }

  // to initialize the database
  Future<Database> initializedatabase() async {
    String databasePath = join(await getDatabasesPath(), "etrade.database");
    var eTradedatabase = await openDatabase(databasePath, version: 1, onCreate: createdatabase);
    return eTradedatabase;
  }

  // create database
  Future<void> createdatabase(Database database, int version) async {
    await database.execute(
        "Create table Todos(id integer primary key, title text, body text)");
  }

  // to get data
  Future<List> getTodos() async {
    Database? database = await this.database;
    var result = await database!.query("Todos");
    //return result;
    return List.generate(result.length, (i) {
      return Todo.fromObject(result[i]);
    });
  }


  // to add and save the data
  Future<int?> insert(Todo todo) async {
    Database? database = await this.database;
    var result = await database?.insert("Todos", todo.toMap());
    return result;
  }


  // to Delete the data
  Future<int?> delete(int id) async {
    Database? database = await this.database;
    var result = await database?.rawDelete("delete from Todos where id= $id");
    return result;
  }

  // to update the data
  Future<int?> update(Todo todo) async {
    Database? database = await this.database;
    var result = await database?.update("Todos", todo.toMap(),
        where: "id=?", whereArgs: [todo.id]);
    return result;
  }
}