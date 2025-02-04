import 'package:app_taski/core/model/app_model.dart';
import 'package:app_taski/core/repository/app_repository.dart';
import 'package:app_taski/features/task_done/task_done_viewmodel/task_done_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'create_tasks_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  late TaskDoneViewModel viewModel;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    viewModel = TaskDoneViewModel(
      mockTaskRepository,
    );
  });

  group(
    'TaskDoneViewModel - loadCompletedTasks',
    () {
      test(
        'Deve carregar as tarefas concluídas com sucesso',
        () async {
          final tasks = [
            Task(
              id: 1,
              title: 'Tarefa 1',
              completed: true,
            ),
            Task(
              id: 2,
              title: 'Tarefa 2',
              completed: true,
            ),
          ];
          when(
            mockTaskRepository.getTasks(
              completed: true,
            ),
          ).thenAnswer(
            (_) async => tasks,
          );

          await viewModel.loadCompletedTasks();

          expect(
            viewModel.isLoading,
            false,
          );
          expect(
            viewModel.completedTasks,
            tasks,
          );
          verify(
            mockTaskRepository.getTasks(
              completed: true,
            ),
          ).called(
            1,
          );
        },
      );

      test(
        'Deve lidar com erros ao carregar as tarefas',
        () async {
          when(
            mockTaskRepository.getTasks(
              completed: true,
            ),
          ).thenAnswer(
            (_) async => Future.error(
              Exception(
                'Erro',
              ),
            ),
          );

          await viewModel.loadCompletedTasks();

          expect(
            viewModel.isLoading,
            false,
          );
          expect(
            viewModel.completedTasks,
            [],
          );
          verify(
            mockTaskRepository.getTasks(
              completed: true,
            ),
          ).called(
            1,
          );
        },
      );

      test(
        'Deve atualizar o estado de carregamento',
        () async {
          when(
            mockTaskRepository.getTasks(
              completed: true,
            ),
          ).thenAnswer(
            (_) async => [],
          );

          await viewModel.loadCompletedTasks();

          expect(
            viewModel.isLoading,
            false,
          );
        },
      );
    },
  );

  group(
    'TaskDoneViewModel - deleteTask',
    () {
      test(
        'Deve deletar uma tarefa e atualizar a lista',
        () async {
          final tasks = [
            Task(
              id: 1,
              title: 'Tarefa 1',
              completed: true,
            ),
            Task(
              id: 2,
              title: 'Tarefa 2',
              completed: true,
            ),
          ];
          viewModel.setCompletedTasksForTesting(
            tasks,
          );

          when(
            mockTaskRepository.deleteTask(
              1,
            ),
          ).thenAnswer(
            (_) async => Future.value(
              1,
            ),
          );

          await viewModel.deleteTask(
            1,
          );

          expect(
            viewModel.completedTasks.length,
            1,
          );
          expect(
            viewModel.completedTasks[0].id,
            2,
          );
          verify(mockTaskRepository.deleteTask(1)).called(
            1,
          );
        },
      );
    },
  );

  group(
    'TaskDoneViewModel - deleteAllTasks',
    () {
      test(
        'Deve deletar todas as tarefas e limpar a lista',
        () async {
          final tasks = [
            Task(
              id: 1,
              title: 'Tarefa 1',
              completed: true,
            ),
            Task(
              id: 2,
              title: 'Tarefa 2',
              completed: true,
            ),
          ];
          viewModel.setCompletedTasksForTesting(
            tasks,
          );
          when(
            mockTaskRepository.deleteAllTasks(),
          ).thenAnswer(
            (_) async => Future.value(
              2,
            ),
          );

          await viewModel.deleteAllTasks();

          expect(
            viewModel.completedTasks.length,
            0,
          );
          verify(
            mockTaskRepository.deleteAllTasks(),
          ).called(1);
        },
      );
    },
  );
}
