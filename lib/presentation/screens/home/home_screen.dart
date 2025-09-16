import 'package:flutter/material.dart';
import 'package:noviindus_technologies_m_t/core/extensions/navigation_extension.dart';
import 'package:noviindus_technologies_m_t/presentation/screens/registration/registration_screen.dart';
import 'package:noviindus_technologies_m_t/presentation/widget/custom_app_bar.dart';
import 'package:noviindus_technologies_m_t/presentation/widget/custom_button.dart';
import 'package:provider/provider.dart';
 import '../../providers/patient_provider.dart';
import '../../widget/custom_patient_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadPatients();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomButton(title: "Register Now", onTap: () {
        pushToScreen(RegistrationScreen(), context);
      }),
       body: SafeArea(
         child: Consumer<PatientProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
         
            if (provider.patients.isEmpty) {
              return const Center(child: Text('No patients found'));
            }
         
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CustomAppBar(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: provider.patients.length,
                      itemBuilder: (context, index) {
                        final patient = provider.patients[index];
                        return CustomPatientTitle(index: index, patient: patient);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
               ),
       ),
    );
  }

  Future<void> _loadPatients() async {
    final patientProvider = context.read<PatientProvider>();
    await patientProvider.fetchPatients();
  }
}
