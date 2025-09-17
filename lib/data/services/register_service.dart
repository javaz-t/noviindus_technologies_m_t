import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:noviindus_technologies_m_t/core/constants/app_constant.dart';
import 'package:noviindus_technologies_m_t/core/utils/shared_prefs_storage.dart';

class RegisterService {
  Future<List<String>> fetchBranchNames() async {
    try {
      var token = await SharedPrefsStorage.getToken();
      final response = await http.get(
        Uri.parse("${AppConstants.baseUrl}BranchList"),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == true && data['branches'] != null) {
          return (data['branches'] as List)
              .map<String>((branch) => branch['name'].toString())
              .toList();
        } else {
          throw Exception('Invalid response data');
        }
      } else {
        throw Exception('Failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<String>> fetchTreatmentNames() async {
    final url = Uri.parse('${AppConstants.baseUrl}TreatmentList');
    var token = await SharedPrefsStorage.getToken();
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final treatments = decoded['treatments'] as List<dynamic>;
      return treatments.map((e) => e['name'].toString()).toList();
    } else {
      throw Exception('Failed to load treatment names');
    }
  }
}
