import 'package:flutter/material.dart';
import 'package:noviindus_technologies_m_t/presentation/providers/auth_provider.dart';
import 'package:noviindus_technologies_m_t/presentation/providers/patient_provider.dart';
import 'package:noviindus_technologies_m_t/presentation/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';

import 'data/repository/auth_repository.dart';
import 'data/services/auth_service.dart';
import 'data/services/patient_services.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(AuthRepository(AuthService())),
        ),
        ChangeNotifierProvider(
          create: (_) => PatientProvider(PatientService()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:SplashScreen(),
    );
  }
}

