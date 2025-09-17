import 'package:flutter/material.dart';
import 'package:noviindus_technologies_m_t/data/repository/register_repository.dart';
import 'package:noviindus_technologies_m_t/data/services/register_service.dart';
import 'package:noviindus_technologies_m_t/presentation/providers/auth_provider.dart';
import 'package:noviindus_technologies_m_t/presentation/providers/patient_provider.dart';
import 'package:noviindus_technologies_m_t/presentation/providers/register_provider.dart';
import 'package:noviindus_technologies_m_t/presentation/screens/invoice/invoice_screen.dart';
import 'package:noviindus_technologies_m_t/presentation/screens/registration/registration_screen.dart';
import 'package:provider/provider.dart';

import 'data/repository/auth_repository.dart';
import 'data/services/auth_service.dart';
import 'data/services/patient_services.dart';
import 'domain/entities/invoice_model.dart';
import 'domain/entities/treatment.dart';

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
        ChangeNotifierProvider(
          create: (_) =>
              RegisterProvider(RegisterRepository(RegisterService())),
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
      home: RegistrationScreen(), //InvoiceScreen  (invoice: dummyInvoice),
    );
  }
}

final dummyInvoice = InvoiceModel(
  bookedOn: '16/09/2025',
  name: 'John Doe',
  address: '123 Main Street, Cityville',
  whatsappNumber: '+919876543210',
  treatmentDate: '21/02/2024',
  treatmentTime: '11:00 AM',
  treatments: [
    Treatment(package: 'Hair Transplant', price: 2000, female: 2, male: 5),
    Treatment(package: 'PRP Therapy', price: 1500, female: 2, male: 5),
    Treatment(package: 'PRP dsfsd Therapy', price: 1500, female: 2, male: 5),
  ],
  totalAmount: 3500.0,
  discountAmount: 500.0,
  advanceAmount: 1000.0,
  remainingAmount: 2000.0,
  balanceAmount: 2500.0,
);
