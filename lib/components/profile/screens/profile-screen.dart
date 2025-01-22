import 'package:flutter/material.dart';
import 'package:remedio_certeiro/screens-routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Exemplo de dados do usuário. Eles podem ser passados via um modelo ou obtidos de um banco de dados
    const String name = "João Silva";
    const String phone = "(11) 91234-5678";
    const String age = "30 anos";
    const String cpf = "123.456.789-00";
    const String email = "joao.silva@example.com";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Nome
            const Row(
              children: [
                Icon(Icons.person),
                SizedBox(width: 8),
                Text('Nome: $name', style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 16),

            // Telefone
            const Row(
              children: [
                Icon(Icons.phone),
                SizedBox(width: 8),
                Text('Telefone: $phone', style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 16),

            // Idade
            const Row(
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 8),
                Text('Idade: $age', style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 16),

            // CPF
            const Row(
              children: [
                Icon(Icons.credit_card),
                SizedBox(width: 8),
                Text('CPF: $cpf', style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 16),

            // E-mail
            const Row(
              children: [
                Icon(Icons.email),
                SizedBox(width: 8),
                Text('E-mail: $email', style: TextStyle(fontSize: 16)),
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
    );
  }
}
