import 'dart:convert';

import 'package:http/http.dart' as http;

import 'storage_service.dart';

class ApiService {
  static Future<dynamic> get({required String url}) async {
    final token = await StorageService.getAccessToken();

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    return _handleResponse(response);
  }

  static Future<dynamic> post({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    final token = await StorageService.getAccessToken();

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  static dynamic _handleResponse(http.Response response) {
    final body = response.body.trim();

    if (body.isEmpty) {
      throw Exception('API error (${response.statusCode})');
    }

    final contentType = response.headers['content-type'] ?? '';
    final isJson =
        contentType.contains('application/json') ||
        body.startsWith('{') ||
        body.startsWith('[');

    if (!isJson) {
      throw Exception(
        'Server returned non-JSON response (${response.statusCode}). '
        'Check API URL and make sure backend routes are updated.',
      );
    }

    final decoded = jsonDecode(body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return decoded;
    }

    if (decoded is Map && decoded['message'] != null) {
      throw Exception(decoded['message']);
    }

    throw Exception('API error (${response.statusCode})');
  }
}
