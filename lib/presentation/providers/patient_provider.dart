import 'package:flutter/material.dart';

import '../../data/model/patient_model.dart';
import '../../data/services/patient_services.dart';

class PatientProvider extends ChangeNotifier {
  String _searchQuery = '';
  final TextEditingController searchController = TextEditingController();

  List<PatientModel> get patients {
    if (_searchQuery.isEmpty) return _patients;
    return _patients.where((patient) {
      final query = _searchQuery.toLowerCase();
      return patient.name.toLowerCase().contains(query) ||
          patient.phone.toLowerCase().contains(query);
    }).toList();
  }

  String get searchQuery => _searchQuery;

  set searchQuery(String value) {
    _searchQuery = value;
    notifyListeners(); // 🔥 this triggers rebuild
  }

  final PatientService service;

  List<PatientModel> _patients = [];
  bool _isLoading = false;

  PatientProvider(this.service);

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
