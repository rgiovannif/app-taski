import 'package:app_taski/core/database/app_database.dart';
import 'package:app_taski/core/model/app_model.dart';

class TaskRepository {
  Future<int> createTask(Task task) async {
    final db = await AppDatabase().getDatabase();
    return await db.insert(
      'tasks',
      task.toMap(),
    );
  }

  Future<List<Task>> getTasks({bool completed = false}) async {
    final db = await AppDatabase().getDatabase();
    final results = await db.query(
      'tasks',
      where: 'completed = ?',
      whereArgs: [
        completed ? 1 : 0,
      ],
    );
    return results.map((e) => Task.fromMap(e)).toList();
  }

  Future<int> updateTask(Task task) async {
    final db = await AppDatabase().getDatabase();
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [
        task.id,
      ],
    );
  }

  Future<int> updateTaskStatus(int id, bool completed) async {
    final db = await AppDatabase().getDatabase();
    return await db.update(
      'tasks',
      {
        'completed': completed ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [
        id,
      ],
    );
  }

  Future<List<Task>> searchTasks(String query) async {
    final db = await AppDatabase().getDatabase();
    final results = await db.query(
      'tasks',
      where: 'title LIKE ? OR description LIKE ?',
      whereArgs: [
        '%$query%',
        '%$query%',
      ],
    );

    return results.map((task) => Task.fromMap(task)).toList();
  }

  Future<int> deleteTask(int id) async {
    final db = await AppDatabase().getDatabase();
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllTasks() async {
    final db = await AppDatabase().getDatabase();
    return await db.delete(
      'tasks',
      where: 'completed = ?',
      whereArgs: [1],
    );
  }
}
