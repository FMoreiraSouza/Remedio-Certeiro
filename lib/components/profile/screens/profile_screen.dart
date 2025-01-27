import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/components/profile/controllers/profile_controller.dart';
import 'package:remedio_certeiro/screens_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.controller});

  final ProfileController controller;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        widget.controller.fetchUserData();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Usuário'),
      ),
      body: Consumer<ProfileController>(
        builder: (context, controller, child) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Nome
                    Row(
                      children: [
                        const Icon(Icons.person),
                        const SizedBox(width: 8),
                        Text('Nome: ${controller.user?.name}',
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Telefone
                    Row(
                      children: [
                        const Icon(Icons.phone),
                        const SizedBox(width: 8),
                        Text('Telefone: ${controller.userInfoModel?.phone}',
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Idade
                    Row(
                      children: [
                        const Icon(Icons.calendar_today),
                        const SizedBox(width: 8),
                        Text('Idade: ${controller.userInfoModel?.age}',
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // CPF
                    Row(
                      children: [
                        const Icon(Icons.credit_card),
                        const SizedBox(width: 8),
                        Text('CPF: ${controller.userInfoModel?.cpf}',
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // E-mail
                    Row(
                      children: [
                        const Icon(Icons.email),
                        const SizedBox(width: 8),
                        Text('E-mail: ${controller.user?.email}',
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red)),
                      onPressed: () {
                        Navigator.pushNamed(context, ScreensRoutes.login);
                      },
                      child: const Text(
                        "Sair",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              if (controller.isLoading)
                Container(
                  color: Colors.black.withValues(alpha: 0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
