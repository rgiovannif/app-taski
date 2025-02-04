import 'package:app_taski/core/repository/app_repository.dart';
import 'package:flutter/material.dart';
import 'package:app_taski/core/model/app_model.dart';

class TaskDoneViewModel extends ChangeNotifier {
  final TaskRepository _taskRepository;

  TaskDoneViewModel(this._taskRepository);

  List<Task> _completedTasks = [];
  bool _isLoading = false;

  List<Task> get completedTasks => _completedTasks;
  bool get isLoading => _isLoading;

  Future<void> loadCompletedTasks() async {
    _isLoading = true;
    notifyListeners();

    try {
      _completedTasks = await _taskRepository.getTasks(
        completed: true,
      );
    } catch (e) {
      debugPrint(
        'Erro ao carregar tarefas concluídas: $e',
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteTask(int id) async {
    await _taskRepository.deleteTask(
      id,
    );
    _completedTasks.removeWhere(
      (task) => task.id == id,
    );
    notifyListeners();
  }

  Future<void> deleteAllTasks() async {
    await _taskRepository.deleteAllTasks();
    _completedTasks.clear();
    notifyListeners();
  }

  @visibleForTesting
  setCompletedTasksForTesting(List<Task> tasks) {
    _completedTasks = tasks;
    notifyListeners();
  }
}
