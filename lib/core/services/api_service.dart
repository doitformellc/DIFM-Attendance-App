import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<dynamic> post({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        ...?headers,
      },
      body: jsonEncode(body),
    );

    return jsonDecode(response.body);
  }
}