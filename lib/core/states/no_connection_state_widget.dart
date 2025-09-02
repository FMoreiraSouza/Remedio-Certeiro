import 'package:flutter/material.dart';
import 'package:remedio_certeiro/core/constants/app_colors.dart';
import 'package:remedio_certeiro/core/constants/texts.dart';

class NoConnectionStateWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const NoConnectionStateWidget({
    super.key,
    required this.onRetry,
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
              Icons.wifi_off,
              size: 64,
              color: AppColors.warning,
            ),
            const SizedBox(height: 16),
            Text(
              Texts.noConnection,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              Texts.checkConnection,
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
