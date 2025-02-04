import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'assets/images/logo.jpg',
        ),
        Row(
          children: [
            const Text(
              'John',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              width: 16,
            ),
            ClipOval(
              child: Image.asset(
                'assets/images/perfil.jpg',
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            )
          ],
        )
      ],
    );
  }
}
