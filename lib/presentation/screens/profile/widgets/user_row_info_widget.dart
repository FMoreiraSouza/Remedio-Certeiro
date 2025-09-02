import 'package:flutter/material.dart';

class UserInfoRowWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  const UserInfoRowWidget({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
