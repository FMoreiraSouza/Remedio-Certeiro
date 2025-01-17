import 'package:flutter/material.dart';

class MedicalButton extends StatelessWidget {
  const MedicalButton({
    super.key,
    required this.function,
    required this.icon,
    required this.text,
  });

  final Function(BuildContext context) function;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.yellow.shade200),
      ),
      onPressed: () => function(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const SizedBox(width: 4),
          Text(text),
        ],
      ),
    );
  }
}
