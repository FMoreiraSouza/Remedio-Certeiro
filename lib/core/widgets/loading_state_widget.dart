import 'package:flutter/material.dart';
import 'package:remedio_certeiro/core/constants/colors.dart';

class LoadingStateWidget extends StatelessWidget {
  const LoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
