import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = "http://your-server-ip:8000/api";

  Future<Map<String, dynamic>> fetchProducts() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/products'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }
}
