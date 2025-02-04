import 'package:app_taski/core/components/page_header.dart';
import 'package:app_taski/core/components/rich_text_component.dart';
import 'package:app_taski/features/create_task/create_task_viewmodel/create_task_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _showAddTaskBottomSheet(BuildContext context) {
    final viewModel = context.read<CreateTaskViewModel>();

    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            28,
          ),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  maxLength: 32,
                  cursorColor: Colors.black,
                  controller: _titleController,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.crop_square,
                    ),
                    labelText: 'What\'s in your mind?',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  maxLength: 150,
                  cursorColor: Colors.black,
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.edit,
                    ),
                    labelText: 'Add a note',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      final String title = _titleController.text.trim();
                      final String description =
                          _descriptionController.text.trim();

                      try {
                        await viewModel.createTask(
                          title,
                          description,
                        );
                        Future.delayed(
                          Duration.zero,
                          () {
                            if (mounted) {
                              _titleController.clear();
                              _descriptionController.clear();
                              Navigator.pop(
                                // ignore: use_build_context_synchronously
                                context,
                              );
                            }
                          },
                        );
                      } catch (e) {
                        Text(
                          e.toString(),
                        );
                      }
                    }
                  },
                  child: Consumer<CreateTaskViewModel>(
                    builder: (context, viewModel, child) {
                      return const Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: 32,
                          ),
                          child: Text(
                            'Create',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
              const CustomRichText(
                initialText: 'Welcome, ',
                secondText: 'John',
                thirdText: '.',
                subTitle: 'Create tasks to achieve more.',
              ),
              const SizedBox(
                height: 130,
              ),
              Image.asset(
                'assets/images/empty-list-image.jpg',
              ),
              const SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () => _showAddTaskBottomSheet(
                  context,
                ),
                child: Container(
                  height: 50,
                  width: 151,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        12,
                      ),
                    ),
                    color: Color.fromARGB(
                      255,
                      177,
                      213,
                      241,
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Create task',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
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
