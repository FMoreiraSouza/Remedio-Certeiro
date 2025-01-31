import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/components/profile/controllers/profile_controller.dart';

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
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person),
                    const SizedBox(width: 8),
                    Text('Nome: ${controller.user?.name ?? 'Carregando...'}',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.phone),
                    const SizedBox(width: 8),
                    Text('Telefone: ${controller.userInfoModel?.phone ?? 'Carregando...'}',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.email),
                    const SizedBox(width: 8),
                    Text('E-mail: ${controller.user?.email ?? 'Carregando...'}',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.calendar_today),
                    const SizedBox(width: 8),
                    Text('Idade: ${controller.userInfoModel?.age ?? 'Carregando...'}',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.credit_card),
                    const SizedBox(width: 8),
                    Text('CPF: ${controller.userInfoModel?.cpf ?? 'Carregando...'}',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red)),
                  onPressed: () {
                    controller.logout(context);
                  },
                  child: const Text(
                    "Sair",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
