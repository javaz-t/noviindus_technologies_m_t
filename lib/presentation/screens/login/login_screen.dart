import 'package:flutter/material.dart';
import 'package:noviindus_technologies_m_t/core/extensions/sized_box_extension.dart';

import '../../widget/custom_button.dart';
import '../../widget/custom_text.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/loading_widget.dart';
import '../../widget/terms_and_privacy.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController usernameController = TextEditingController(
    text: "test_user",
  );
  final TextEditingController passwordController = TextEditingController(
    text: "12345678",
  );
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: SingleChildScrollView(
        child: false
            ? LoadingWidget()
            : Column(
          children: [
            Image.asset(
              "assets/images/login.jpg",
              fit: BoxFit.cover,
              height: 217,
              width: double.maxFinite,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  30.vs(),
                  CustomText(
                    text: 'Login or register to book your appointments',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  30.vs(),
                  CustomText(text: 'Email'),
                  5.hs(),
                  CustomTextField(
                    controller: TextEditingController(),
                    hintText: 'Enter your email',
                  ),
                  30.vs(),
                  CustomText(text: 'Password'),
                  5.hs(),
                  CustomTextField(
                    controller: TextEditingController(),
                    hintText: 'Enter password',
                  ),
                  30.vs(),
                  CustomButton(
                    title: "Login",
                    onTap: ()   {

                    },
                  ),
                  30.vs(),
                  TermsAndPrivacyText(
                    onTermsTap: () {},
                    onPrivacyTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
