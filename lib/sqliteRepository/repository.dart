import 'package:bacala_assignment_3/model/todo_model.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class Repository {

  Future<Database> initializedatabase();
  Future<void> createdatabase(Database database, int version);
  Future<List> getTodos();
  Future<int?> insert(Todo todo);
  Future<int?> delete(int id);
  Future<int?> update(Todo todo);

}