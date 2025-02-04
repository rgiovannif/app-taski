import 'package:app_taski/core/components/card_search_task.dart';
import 'package:app_taski/core/components/page_header.dart';
import 'package:app_taski/core/model/app_model.dart';
import 'package:app_taski/features/search_task/search_task_viewmodel/search_task_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchTaskPage extends StatefulWidget {
  const SearchTaskPage({super.key});

  @override
  State<SearchTaskPage> createState() => _SearchTaskPageState();
}

class _SearchTaskPageState extends State<SearchTaskPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  List<Task> _searchResults = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchTasks(String query) async {
    setState(
      () {
        _isLoading = true;
      },
    );

    try {
      final results = await context.read<SearchTaskViewModel>().searchTasks(
            query,
          );
      setState(
        () {
          _searchResults = results;
        },
      );
    } catch (e) {
      debugPrint(
        'Error searching tasks: $e',
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _taskNotFound() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/empty-list-image.jpg',
            height: 150,
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            'No tasks found',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 26,
              right: 26,
              top: 38,
            ),
            child: Column(
              children: [
                const PageHeader(),
                const SizedBox(
                  height: 32,
                ),
                TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _searchTasks(
                        value,
                      );
                    } else {
                      setState(() {
                        _searchResults = [];
                      });
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.blue,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchResults = [];
                        });
                      },
                    ),
                    hintText: 'Search tasks',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (_isLoading)
                  const CircularProgressIndicator()
                else if (_searchResults.isEmpty)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: _taskNotFound(),
                  )
                else
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final task = _searchResults[index];
                        return CardSearchTask(
                          title: task.title,
                          description: task.description ?? '',
                          clickDeleteTask: () async {
                            await context
                                .read<SearchTaskViewModel>()
                                .deleteTask(
                                  task.id!,
                                );
                            setState(
                              () {
                                _searchResults.removeAt(index);
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
      ),
    );
  }
}
