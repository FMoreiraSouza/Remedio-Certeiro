import 'package:flutter/material.dart';
import 'package:remedio_certeiro/core/constants/app_colors.dart';
import 'package:remedio_certeiro/core/constants/texts.dart';

class ErrorStateWidget extends StatelessWidget {
  final VoidCallback onRetry;
  final String message;

  const ErrorStateWidget({
    super.key,
    required this.onRetry,
    this.message = Texts.genericError,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              Texts.error,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text(Texts.tryAgain),
            ),
          ],
        ),
      ),
    );
  }
}
