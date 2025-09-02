import 'package:flutter/material.dart';
import 'package:remedio_certeiro/core/constants/app_colors.dart';

class LogoutButtonWidget extends StatelessWidget {
  final VoidCallback onLogout;

  const LogoutButtonWidget({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
      onPressed: onLogout,
      child: const Text('Sair', style: TextStyle(color: Colors.white)),
    );
  }
}
