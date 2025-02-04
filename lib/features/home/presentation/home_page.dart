import 'package:app_taski/core/components/card_todo_task.dart';
import 'package:app_taski/core/components/page_header.dart';
import 'package:app_taski/core/components/rich_text_component.dart';
import 'package:app_taski/features/home/home_viewmodel/home_viewmodel.dart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () async {
        if (mounted) {
          await Provider.of<HomeViewModel>(context, listen: false).loadTasks();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 26,
            vertical: 38,
          ),
          child: Column(
            children: [
              const PageHeader(),
              const SizedBox(
                height: 32,
              ),
              CustomRichText(
                initialText: 'Welcome, ',
                secondText: 'John',
                thirdText: '.',
                subTitle: 'You\'ve got ${viewModel.numberOfTasks} tasks to do',
              ),
              const SizedBox(
                height: 32,
              ),
              Expanded(
                child: viewModel.tasks.isEmpty
                    ? const Center(
                        child: Text(
                          "You have no tasks to do.",
                        ),
                      )
                    : NotificationListener<ScrollNotification>(
                        onNotification: (scrollInfo) {
                          if (scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent &&
                              !viewModel.isLoading) {
                            viewModel.loadTasks();
                          }
                          return false;
                        },
                        child: ListView.builder(
                          itemCount: viewModel.tasks.length +
                              (viewModel.isLoading ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index < viewModel.tasks.length) {
                              final task = viewModel.tasks[index];
                              return CardToDoTask(
                                title: task.title,
                                isChecked: viewModel.isTaskChecked(
                                  task.id!,
                                ),
                                onChanged: (value) {
                                  if (value == true) {
                                    viewModel.toggleTaskChecked(
                                      task.id!,
                                    );
                                    Future.delayed(
                                      const Duration(
                                        milliseconds: 300,
                                      ),
                                      () {
                                        viewModel.markTaskAsDone(
                                          task,
                                        );
                                      },
                                    );
                                  }
                                },
                                onOptionsClick: () {},
                              );
                            }
                            return Container();
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
