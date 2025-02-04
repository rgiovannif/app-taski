import 'package:app_taski/core/model/app_model.dart';
import 'package:app_taski/core/repository/app_repository.dart';
import 'package:app_taski/features/home/home_viewmodel/home_viewmodel.dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_tasks_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  late HomeViewModel viewModel;
  late MockTaskRepository mockTaskRepository;

  setUp(
    () {
      mockTaskRepository = MockTaskRepository();
      viewModel = HomeViewModel(
        mockTaskRepository,
      );
    },
  );

  group(
    'HomeViewModel - loadTasks',
    () {
      test(
        'Deve carregar as tarefas pendentes com sucesso',
        () async {
          final tasks = [
            Task(
              id: 1,
              title: 'Tarefa 1',
              completed: false,
            ),
            Task(
              id: 2,
              title: 'Tarefa 2',
              completed: false,
            ),
          ];
          when(
            mockTaskRepository.getTasks(
              completed: false,
            ),
          ).thenAnswer(
            (_) async => tasks,
          );

          await viewModel.loadTasks();

          expect(
            viewModel.isLoading,
            false,
          );
          expect(
            viewModel.tasks,
            tasks,
          );
          expect(
            viewModel.isTaskChecked(
              1,
            ),
            false,
          );
          expect(
            viewModel.isTaskChecked(
              2,
            ),
            false,
          );
          verify(
            mockTaskRepository.getTasks(
              completed: false,
            ),
          ).called(
            1,
          );
        },
      );

      test(
        'Deve lidar com erros ao carregar as tarefas',
        () async {
          when(mockTaskRepository.getTasks(completed: false)).thenAnswer(
            (_) async => Future.error(
              Exception(
                'Erro',
              ),
            ),
          );

          try {
            await viewModel.loadTasks();
            // ignore: empty_catches
          } catch (e) {}

          expect(
            viewModel.isLoading,
            false,
          );
          expect(
            viewModel.tasks,
            [],
          );
          verify(
            mockTaskRepository.getTasks(
              completed: false,
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
              completed: false,
            ),
          ).thenAnswer(
            (_) async => [],
          );

          await viewModel.loadTasks();

          expect(
            viewModel.isLoading,
            false,
          );
        },
      );
    },
  );

  group(
    'HomeViewModel - toggleTaskChecked',
    () {
      test(
        'Deve alternar o estado de checked da tarefa',
        () async {
          final tasks = [
            Task(
              id: 1,
              title: 'Tarefa 1',
              completed: false,
            ),
          ];
          when(
            mockTaskRepository.getTasks(
              completed: false,
            ),
          ).thenAnswer(
            (_) async => tasks,
          );
          await viewModel.loadTasks();

          viewModel.toggleTaskChecked(
            1,
          );

          expect(
            viewModel.isTaskChecked(
              1,
            ),
            true,
          );

          viewModel.toggleTaskChecked(
            1,
          );

          expect(
            viewModel.isTaskChecked(
              1,
            ),
            false,
          );
        },
      );
    },
  );

  group(
    'HomeViewModel - markTaskAsDone',
    () {
      test(
        'Deve marcar a tarefa como concluída e removê-la da lista',
        () async {
          final task = Task(
            id: 1,
            title: 'Tarefa 1',
            completed: false,
          );
          final tasks = [
            task,
          ];
          when(
            mockTaskRepository.getTasks(
              completed: false,
            ),
          ).thenAnswer(
            (_) async => tasks,
          );
          await viewModel.loadTasks();

          when(
            mockTaskRepository.updateTaskStatus(
              1,
              true,
            ),
          ).thenAnswer(
            (_) async => Future.value(
              1,
            ),
          );

          await viewModel.markTaskAsDone(
            task,
          );

          expect(
            viewModel.tasks.length,
            0,
          );
          verify(
            mockTaskRepository.updateTaskStatus(
              1,
              true,
            ),
          ).called(
            1,
          );
        },
      );
    },
  );
}
