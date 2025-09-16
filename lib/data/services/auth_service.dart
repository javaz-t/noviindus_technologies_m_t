import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final String baseUrl = 'https://flutter-amr.noviindus.in/api/Login';

  Future<String> login(String username, String password) async {
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl));
    request.fields['username'] = username;
    request.fields['password'] = password;

    // optional Authorization header
    request.headers['Authorization'] = 'Bearer <any-default-token>';

    final response = await request.send();
    final resString = await response.stream.bytesToString();
    final resJson = json.decode(resString);

    if (response.statusCode == 200 && resJson['status'] == true) {
      return resJson['token']; // return token
    } else {
      throw Exception(resJson['message'] ?? 'Login failed');
    }
  }
}
