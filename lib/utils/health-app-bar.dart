import 'package:flutter/material.dart';
import 'package:remedio_certeiro/screens-routes.dart';

class HealthAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HealthAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: const Icon(Icons.medical_services),
          onPressed: () {
            Navigator.pushNamed(context, ScreensRoutes.medicineRegister);
          },
        ),
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            Navigator.pushNamed(context, ScreensRoutes.profile);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
