import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IntervalSelectorWidget extends StatelessWidget {
  final TextEditingController intervalController;
  final Function(int) onIntervalChanged;

  const IntervalSelectorWidget({
    super.key,
    required this.intervalController,
    required this.onIntervalChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Intervalo entre as doses:'),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                final currentInterval = int.tryParse(intervalController.text) ?? 0;
                if (currentInterval >= 1) {
                  onIntervalChanged(currentInterval - 1);
                }
              },
            ),
            SizedBox(
              width: 60,
              child: TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: intervalController,
                onChanged: (value) {
                  final newInterval = int.tryParse(value);
                  if (newInterval != null) {
                    onIntervalChanged(newInterval);
                  }
                },
                validator: (value) =>
                    int.tryParse(value ?? '') == null || int.tryParse(value!)! <= 0
                        ? 'Inválido.'
                        : null,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                final currentInterval = int.tryParse(intervalController.text) ?? 0;
                onIntervalChanged(currentInterval + 1);
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}