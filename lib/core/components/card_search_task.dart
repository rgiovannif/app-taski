import 'package:flutter/material.dart';

class CardSearchTask extends StatelessWidget {
  final String title;
  final String description;
  final Function()? clickDeleteTask;

  const CardSearchTask({
    super.key,
    required this.title,
    required this.description,
    required this.clickDeleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(
        255,
        241,
        238,
        238,
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          description,
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: clickDeleteTask,
        ),
      ),
    );
  }
}
