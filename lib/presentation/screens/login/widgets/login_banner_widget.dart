// Widget para exibir o banner superior da tela de login.
import 'package:flutter/material.dart';
import 'package:remedio_certeiro/core/constants/colors.dart';

class LoginBannerWidget extends StatelessWidget {
  const LoginBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageHeight = constraints.maxHeight / 3;
        return Container(
          color: AppColors.primary,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('resources/images/app_banner.png'),
                fit: BoxFit.contain,
              ),
            ),
            height: imageHeight,
          ),
        );
      },
    );
  }
}
