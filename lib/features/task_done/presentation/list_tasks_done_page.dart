import 'package:app_taski/core/components/card_completed_task.dart';
import 'package:app_taski/core/components/page_header.dart';
import 'package:app_taski/features/task_done/task_done_viewmodel/task_done_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListTasksDonePage extends StatefulWidget {
  const ListTasksDonePage({super.key});

  @override
  State<ListTasksDonePage> createState() => _ListTasksDonePageState();
}

class _ListTasksDonePageState extends State<ListTasksDonePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () async {
        if (mounted) {
          await Provider.of<TaskDoneViewModel>(
            context,
            listen: false,
          ).loadCompletedTasks();
        }
      },
    );
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context,
      String taskTitle, Future<void> Function() onDelete) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirm Deletion',
          ),
          content: Text(
            "Are you sure you want to delete the task '$taskTitle'?",
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await onDelete();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskDoneViewModel>(
      context,
    );

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Completed Tasks',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    child: const Text(
                      'Delete all',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    onTap: () async {
                      await _showDeleteConfirmationDialog(
                        context,
                        "all completed tasks",
                        () async {
                          await viewModel.deleteAllTasks();
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Expanded(
                child: viewModel.completedTasks.isEmpty
                    ? const Center(
                        child: Text(
                          "You have no completed tasks.",
                        ),
                      )
                    : ListView.builder(
                        itemCount: viewModel.completedTasks.length,
                        itemBuilder: (context, index) {
                          final task = viewModel.completedTasks[index];
                          return CardCompletedTask(
                            title: task.title,
                            clickDeleteTask: () async {
                              await _showDeleteConfirmationDialog(
                                context,
                                task.title,
                                () async {
                                  await viewModel.deleteTask(
                                    task.id!,
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
