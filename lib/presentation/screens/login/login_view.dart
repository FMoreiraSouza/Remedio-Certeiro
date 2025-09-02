import 'package:flutter/material.dart';
import 'package:remedio_certeiro/core/utils/validators.dart';
import 'package:remedio_certeiro/presentation/screens/login/widgets/login_banner_widget.dart';
import 'package:remedio_certeiro/presentation/screens/login/widgets/login_form_widget.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final validators = Validators();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            flex: 3,
            child: LoginBannerWidget(),
          ),
          Expanded(
            flex: 3,
            child: LoginFormWidget(formKey: formKey, validators: validators),
          ),
        ],
      ),
    );
  }
}
