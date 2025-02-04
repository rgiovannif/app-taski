import 'package:app_taski/core/repository/app_repository.dart';
import 'package:app_taski/features/create_task/create_task_viewmodel/create_task_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:app_taski/core/model/app_model.dart';
import 'create_tasks_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  late CreateTaskViewModel viewModel;
  late MockTaskRepository mockTaskRepository;

  setUp(
    () {
      mockTaskRepository = MockTaskRepository();
      viewModel = CreateTaskViewModel(
        mockTaskRepository,
      );
    },
  );

  group(
    'CreateTaskViewModel - createTask',
    () {
      test(
        'Deve criar uma tarefa com sucesso',
        () async {
          const title = 'Tarefa Teste';
          const description = 'Descrição da Tarefa Teste';
          final task = Task(
            title: title,
            description: description,
            completed: false,
          );
          when(
            mockTaskRepository.createTask(
              any,
            ),
          ).thenAnswer(
            (_) async => Future.value(
              1,
            ),
          );

          await viewModel.createTask(
            title,
            description,
          );

          verify(
            mockTaskRepository.createTask(
              argThat(
                predicate(
                  (actualTask) {
                    final taskReal = actualTask as Task;
                    return taskReal.title == task.title &&
                        taskReal.description == task.description &&
                        taskReal.completed == task.completed;
                  },
                ),
              ),
            ),
          ).called(
            1,
          );
          expect(
            viewModel.isLoading,
            false,
          );
        },
      );

      test(
        'Deve lançar uma exceção se o título estiver vazio',
        () async {
          const title = '';
          const description = 'Descrição da Tarefa Teste';

          expect(
            () => viewModel.createTask(
              title,
              description,
            ),
            throwsA(
              isA<Exception>(),
            ),
          );
          expect(
            viewModel.isLoading,
            false,
          );
        },
      );

      test(
        'Deve lançar uma exceção se a descrição estiver vazia',
        () async {
          const title = 'Tarefa Teste';
          const description = '';
          expect(
            () => viewModel.createTask(
              title,
              description,
            ),
            throwsA(
              isA<Exception>(),
            ),
          );
          expect(
            viewModel.isLoading,
            false,
          );
        },
      );

      test(
        'Deve lidar com erros do repositório',
        () async {
          const title = 'Tarefa Teste';
          const description = 'Descrição da Tarefa Teste';
          when(mockTaskRepository.createTask(any)).thenAnswer(
            (_) async => Future.error(
              Exception('Erro no repositório'),
            ),
          );

          try {
            await viewModel.createTask(
              title,
              description,
            );
            // ignore: empty_catches
          } catch (e) {}

          expect(
            viewModel.isLoading,
            false,
          );
        },
      );

      test(
        'Deve atualizar o estado de carregamento',
        () async {
          const title = 'Tarefa Teste';
          const description = 'Descrição da Tarefa Teste';
          when(
            mockTaskRepository.createTask(
              any,
            ),
          ).thenAnswer(
            (_) async => Future.value(
              1,
            ),
          );

          await viewModel.createTask(
            title,
            description,
          );

          expect(
            viewModel.isLoading,
            false,
          );
        },
      );
    },
  );
}
