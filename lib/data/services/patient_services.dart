import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/app_constant.dart';
import '../../core/utils/shared_prefs_storage.dart';
import '../model/patient_model.dart';

class PatientService {

  Future<List<PatientModel>> fetchPatients() async {
     final token = await SharedPrefsStorage.getToken();
    if (token == null) throw Exception('Token not found');

    final response = await http.get(
      Uri.parse('${AppConstants.baseUrl}PatientList?page=1&limit=20'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return PatientModel.fromJsonList(jsonData['patient']);
    } else {
      throw Exception('Failed to fetch patients');
    }
  }
}
