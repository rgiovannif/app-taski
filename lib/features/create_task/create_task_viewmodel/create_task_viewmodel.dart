import 'package:app_taski/core/model/app_model.dart';
import 'package:app_taski/core/repository/app_repository.dart';
import 'package:flutter/material.dart';

class CreateTaskViewModel extends ChangeNotifier {
  final TaskRepository _taskRepository;
  bool _isLoading = false;

  CreateTaskViewModel(this._taskRepository);

  bool get isLoading => _isLoading;

  Future<void> createTask(String title, String description) async {
    if (title.isEmpty || description.isEmpty) {
      throw Exception(
        'Title and description cannot be empty',
      );
    }

    _isLoading = true;
    notifyListeners();

    try {
      final task = Task(
        title: title,
        description: description,
        completed: false,
      );
      await _taskRepository.createTask(
        task,
      );

      Future.delayed(
        const Duration(
          seconds: 3,
        ),
      );
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
