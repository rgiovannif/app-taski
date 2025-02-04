import 'package:app_taski/features/create_task/presentation/create_task_page.dart';
import 'package:app_taski/core/components/bottom_navigator_bar.dart';
import 'package:app_taski/features/home/presentation/home_page.dart';
import 'package:app_taski/features/task_done/presentation/list_tasks_done_page.dart';
import 'package:app_taski/features/search_task/presentation/search_task_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomBottomNavigationBar(
        screens: [
          HomePage(),
          CreatePage(),
          SearchTaskPage(),
          ListTasksDonePage(),
        ],
      ),
    );
  }
}
