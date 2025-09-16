import 'package:flutter/material.dart';
import 'package:noviindus_technologies_m_t/core/extensions/navigation_extension.dart';
import 'package:noviindus_technologies_m_t/core/extensions/sized_box_extension.dart';
import 'package:noviindus_technologies_m_t/core/helper/result_dialog.dart';
import 'package:noviindus_technologies_m_t/presentation/providers/auth_provider.dart';
import 'package:noviindus_technologies_m_t/presentation/screens/home/home_screen.dart';
 import 'package:provider/provider.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/loading_widget.dart';
import '../../widget/terms_and_privacy.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return SingleChildScrollView(
            child:  Column(
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
                              text:
                                  'Login or register to book your appointments',
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),

                            CustomTextField(title: 'Email',
                               hintText: 'Enter your email',
                            ),
                             CustomTextField(title: "Password",
                               hintText: 'Enter password',
                            ),
                             authProvider.isLoading
                                ? LoadingWidget()
                                : CustomButton(
                              title: "Login",
                              onTap: () async {
                                bool isSuccess = await authProvider.login(
                                  "test_user",
                                  "12345678",
                                );
                                if(isSuccess){
                                  ToastUtils.showSuccess(context, "logged In  successfully");
                                  pushAndRemoveUntilScreen(HomeScreen(), context);
                                }
                                else{
                                  ToastUtils.showError(context, "Failed to log In");

                                }
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
          );
        },
      ),
    );
  }
}
