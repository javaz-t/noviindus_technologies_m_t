import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noviindus_technologies_m_t/core/extensions/navigation_extension.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../login/login_screen.dart';
import '../home/home_screen.dart'; // Assuming you have a home screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Animation setup
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    // Start animation and check login status
    _controller.forward();
    _checkLoginAndNavigate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/background.png", fit: BoxFit.cover),
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: SvgPicture.asset(
                  "assets/svgs/logo.svg",
                  height: 120,
                  width: 120,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _checkLoginAndNavigate() async {
   await Future.wait([
      Future.delayed(const Duration(seconds: 3)),
      _checkLogin(),
    ]);

    final authProvider = context.read<AuthProvider>();
    final loggedIn = await authProvider.checkLogin();

    if (loggedIn) {
      pushAndRemoveUntilScreen(HomeScreen(), context);
    } else {
      pushAndRemoveUntilScreen(LoginScreen(), context);
    }
  }

  Future<bool> _checkLogin() async {
    final authProvider = context.read<AuthProvider>();
    return await authProvider.checkLogin();
  }
}
