import 'package:app_taski/core/repository/app_repository.dart';
import 'package:app_taski/features/create_task/create_task_viewmodel/create_task_viewmodel.dart';
import 'package:app_taski/features/home/home_viewmodel/home_viewmodel.dart.dart';
import 'package:app_taski/features/search_task/search_task_viewmodel/search_task_viewmodel.dart';
import 'package:app_taski/features/task_done/task_done_viewmodel/task_done_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> getProviders() {
  return [
    ChangeNotifierProvider(
      create: (_) => HomeViewModel(
        TaskRepository(),
      ),
    ),
    ChangeNotifierProvider(
      create: (_) => CreateTaskViewModel(
        TaskRepository(),
      ),
    ),
    ChangeNotifierProvider(
      create: (_) => SearchTaskViewModel(
        TaskRepository(),
      ),
    ),
    ChangeNotifierProvider(
      create: (_) => TaskDoneViewModel(
        TaskRepository(),
      ),
    ),
  ];
}
