import 'package:flutter/material.dart';

class CardToDoTask extends StatelessWidget {
  final String title;
  final bool isChecked;
  final ValueChanged<bool?> onChanged;
  final VoidCallback? onOptionsClick;

  const CardToDoTask({
    super.key,
    required this.title,
    required this.isChecked,
    required this.onChanged,
    this.onOptionsClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 8,
      ),
      height: 56,
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
              Checkbox(
                checkColor: Colors.white,
                activeColor: Colors.blue,
                side: const BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
                value: isChecked,
                onChanged: onChanged,
              ),
              Text(
                title,
                style: TextStyle(
                  decoration: isChecked ? TextDecoration.lineThrough : null,
                  color: isChecked ? Colors.grey : Colors.black,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onOptionsClick,
            child: const Icon(
              Icons.more_horiz,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
