import 'package:flutter/material.dart';
import 'package:remedio_certeiro/core/constants/colors.dart';
import 'package:remedio_certeiro/presentation/screens/profile/profile_viewmodel.dart';

class LogoutButtonWidget extends StatelessWidget {
  final ProfileViewModel viewModel;

  const LogoutButtonWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
      onPressed: () => viewModel.logout(context),
      child: const Text('Sair', style: TextStyle(color: Colors.white)),
    );
  }
}
