import 'package:flutter/material.dart';

import '../../data/model/patient_model.dart';
import '../../data/services/patient_services.dart';

class PatientProvider extends ChangeNotifier {
  final PatientService service;

  List<PatientModel> _patients = [];
  bool _isLoading = false;

  PatientProvider(this.service);

  List<PatientModel> get patients => _patients;
  bool get isLoading => _isLoading;

  Future<void> fetchPatients() async {
    _isLoading = true;
    notifyListeners();

    try {
      _patients = await service.fetchPatients();
    } catch (e) {
      _patients = [];
      print('Error fetching patients: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
