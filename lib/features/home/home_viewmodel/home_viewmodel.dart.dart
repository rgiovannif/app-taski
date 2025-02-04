import 'package:app_taski/core/repository/app_repository.dart';
import 'package:flutter/material.dart';
import '../../../core/model/app_model.dart';

class HomeViewModel extends ChangeNotifier {
  final TaskRepository _taskRepository;

  HomeViewModel(this._taskRepository);

  List<Task> _tasks = [];
  bool _isLoading = false;
  final Map<int, bool> _checkedStates = {};

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

  int get numberOfTasks => _tasks.length;

  bool isTaskChecked(int taskId) {
    return _checkedStates[taskId] ?? false;
  }

  void toggleTaskChecked(int taskId) {
    _checkedStates[taskId] = !(isTaskChecked(
      taskId,
    ));
    notifyListeners();
  }

  Future<void> loadTasks() async {
    _isLoading = true;
    notifyListeners();

    try {
      _tasks = await _taskRepository.getTasks(
        completed: false,
      );

      for (var task in _tasks) {
        _checkedStates[task.id!] = false;
      }
    } catch (e) {
      debugPrint(
        'Error loading pending tasks: $e',
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> markTaskAsDone(Task task) async {
    try {
      if (task.id == null) {
        throw Exception(
          "Task ID is null",
        );
      }

      await _taskRepository.updateTaskStatus(
        task.id!,
        true,
      );

      _tasks.remove(
        task,
      );
      notifyListeners();
    } catch (e) {
      debugPrint(
        'Error marking task as complete: $e',
      );
    }
  }
}
