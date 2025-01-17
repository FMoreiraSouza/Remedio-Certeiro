import 'package:flutter/material.dart';

class HealthAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HealthAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.yellow,
      title: const Text("Remédio Certeiro"),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(Icons.medical_services),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
