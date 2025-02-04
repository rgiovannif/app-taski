import 'package:app_taski/core/model/app_model.dart';
import 'package:app_taski/core/repository/app_repository.dart';
import 'package:flutter/material.dart';

class SearchTaskViewModel extends ChangeNotifier {
  final TaskRepository _taskRepository;

  SearchTaskViewModel(
    this._taskRepository,
  );

  Future<List<Task>> searchTasks(String query) async {
    return await _taskRepository.searchTasks(
      query,
    );
  }

  Future<void> deleteTask(int id) async {
    await _taskRepository.deleteTask(
      id,
    );
    notifyListeners();
  }
}
