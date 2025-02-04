import 'package:flutter/material.dart';

class CardCompletedTask extends StatelessWidget {
  final String title;
  final Function()? clickDeleteTask;

  const CardCompletedTask({
    super.key,
    required this.title,
    required this.clickDeleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 8,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10,
        ),
        color: const Color.fromARGB(
          255,
          241,
          238,
          238,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.check_box,
                color: Colors.grey,
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: clickDeleteTask,
            child: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
