import 'package:flutter/material.dart';
import 'package:noviindus_technologies_m_t/core/constants/app_constant.dart';
import 'package:noviindus_technologies_m_t/core/extensions/navigation_extension.dart';
import 'package:noviindus_technologies_m_t/core/extensions/sized_box_extension.dart';
import 'package:noviindus_technologies_m_t/core/utils/shared_prefs_storage.dart';
import 'package:noviindus_technologies_m_t/presentation/screens/login/login_screen.dart';
import 'package:noviindus_technologies_m_t/presentation/screens/registration/registration_screen.dart';
import 'package:noviindus_technologies_m_t/presentation/widget/custom_app_bar.dart';
import 'package:noviindus_technologies_m_t/presentation/widget/custom_button.dart';
import 'package:noviindus_technologies_m_t/presentation/widget/loading_widget.dart';
import 'package:noviindus_technologies_m_t/presentation/widget/search_bar.dart';
import 'package:noviindus_technologies_m_t/presentation/widget/sort_widget.dart';
import 'package:provider/provider.dart';
import '../../providers/patient_provider.dart';
import '../../widget/custom_patient_title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Consumer<PatientProvider>(
        builder: (context, provider, child) {
          return provider.isLoading
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                    title: "Register Now",
                    onTap: () {
                      pushToScreen(const RegistrationScreen(), context);
                    },
                  ),
                );
        },
      ),
      body: SafeArea(
        child: Consumer<PatientProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const LoadingWidget(message: "loading...");
            }


            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  20.vs(),
                  CustomAppBar(
                    onTap: () {
                      showLogoutConfirmationDialog(context);
                    },
                  ),
                  16.vs(),
                  HomeSearchBar(
                    searchController: provider.searchController,
                    onChange: (val) {
                      provider.searchQuery = val;
                    },
                    onSearchTap: () {
                      // TODO: implement search API if required
                    },
                  ),
                  20.vs(),
                  const SortWidget(),
                  5.vs(),
                  Divider(color: AppConstants.borderColor),
                  5.vs(),
                  provider.patients.isEmpty
                      ? const Expanded(
                          child: Center(
                            child: Text('No matching patients found'),
                          ),
                        )
                      : Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              await _loadPatients(context);
                            },
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: provider.patients.length,
                              itemBuilder: (context, index) {
                                final patient = provider.patients[index];
                                return CustomPatientTitle(
                                  index: index,
                                  patient: patient,
                                );
                              },
                            ),
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

  Future<void> _loadPatients(BuildContext context) async {
    final patientProvider = context.read<PatientProvider>();
    await patientProvider.fetchPatients();
  }

  Future<void> showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Log Out'),
              onPressed: () async {
                await SharedPrefsStorage.clearToken();
                pushAndRemoveUntilScreen(LoginScreen(), context);
              },
            ),
          ],
        );
      },
    );
  }
}
