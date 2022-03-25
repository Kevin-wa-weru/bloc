
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/models/form_data.dart';
class NetworkService {
  factory NetworkService() {
    return _networkService;
  }
  NetworkService._internal();
  static final NetworkService _networkService = NetworkService._internal();

  Future<http.Response> getRequest(String endpoint) async {
    try {
      const _baseUrl = 'jsonplaceholder.typicode.com';
      final uri = Uri.https(_baseUrl, endpoint);
      final response = await http.Client().get(
        uri,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> postRequest(String endpoint, FormModel form) async {
    try {
      const _baseUrl = 'https://jsonplaceholder.typicode.com';
      final uri = Uri.https(_baseUrl, '/albums');
      final response =
          await http.Client().post(uri, body: json.encode(form.toMap()));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
