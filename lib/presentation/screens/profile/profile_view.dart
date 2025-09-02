import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/presentation/screens/profile/profile_viewmodel.dart';
import 'package:remedio_certeiro/presentation/screens/profile/widgets/logout_button_widget.dart';
import 'package:remedio_certeiro/presentation/screens/profile/widgets/user_row_info_widget.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileViewModel>().fetchUserData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Usuário'),
      ),
      body: Consumer<ProfileViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final user = viewModel.user;
          final userInfo = viewModel.userInfoModel;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UserInfoRowWidget(
                  icon: Icons.person,
                  text: 'Nome: ${user?.name ?? 'Carregando...'}',
                ),
                const SizedBox(height: 16),
                UserInfoRowWidget(
                  icon: Icons.phone,
                  text: 'Telefone: ${userInfo?.phone ?? 'Carregando...'}',
                ),
                const SizedBox(height: 16),
                UserInfoRowWidget(
                  icon: Icons.email,
                  text: 'E-mail: ${user?.email ?? 'Carregando...'}',
                ),
                const SizedBox(height: 16),
                UserInfoRowWidget(
                  icon: Icons.calendar_today,
                  text: 'Idade: ${userInfo?.age ?? 'Carregando...'}',
                ),
                const SizedBox(height: 16),
                UserInfoRowWidget(
                  icon: Icons.credit_card,
                  text: 'CPF: ${userInfo?.cpf ?? 'Carregando...'}',
                ),
                const SizedBox(height: 32),
                LogoutButtonWidget(onLogout: () => viewModel.logout(context)),
              ],
            ),
          );
        },
      ),
    );
  }
}
