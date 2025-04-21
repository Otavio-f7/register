import 'package:flutter/material.dart';
import 'package:register/ui/_core/app_colors.dart';
import 'package:register/ui/register/widgets/form_register.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: 550,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 20,
              children: [
                Center(child: Image.asset('assets/logo/logo-colorido.webp')),
                Text(
                    'Seja Bem vindo Parcero',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.mainColor
                ),),
                FormRegister(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}