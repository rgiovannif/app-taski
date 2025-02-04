// Mocks generated by Mockito 5.4.4 from annotations
// in app_taski/test/metods_test/create_tasks_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:app_taski/core/model/app_model.dart' as _i4;
import 'package:app_taski/core/repository/app_repository.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [TaskRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTaskRepository extends _i1.Mock implements _i2.TaskRepository {
  MockTaskRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<int> createTask(_i4.Task? task) => (super.noSuchMethod(
        Invocation.method(
          #createTask,
          [task],
        ),
        returnValue: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);

  @override
  _i3.Future<List<_i4.Task>> getTasks({bool? completed = false}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTasks,
          [],
          {#completed: completed},
        ),
        returnValue: _i3.Future<List<_i4.Task>>.value(<_i4.Task>[]),
      ) as _i3.Future<List<_i4.Task>>);

  @override
  _i3.Future<int> updateTask(_i4.Task? task) => (super.noSuchMethod(
        Invocation.method(
          #updateTask,
          [task],
        ),
        returnValue: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);

  @override
  _i3.Future<int> updateTaskStatus(
    int? id,
    bool? completed,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateTaskStatus,
          [
            id,
            completed,
          ],
        ),
        returnValue: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);

  @override
  _i3.Future<List<_i4.Task>> searchTasks(String? query) => (super.noSuchMethod(
        Invocation.method(
          #searchTasks,
          [query],
        ),
        returnValue: _i3.Future<List<_i4.Task>>.value(<_i4.Task>[]),
      ) as _i3.Future<List<_i4.Task>>);

  @override
  _i3.Future<int> deleteTask(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteTask,
          [id],
        ),
        returnValue: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);

  @override
  _i3.Future<int> deleteAllTasks() => (super.noSuchMethod(
        Invocation.method(
          #deleteAllTasks,
          [],
        ),
        returnValue: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);
}
