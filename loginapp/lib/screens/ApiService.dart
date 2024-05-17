import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {

  Future<Map<String, dynamic>> fetchProducts() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/products'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<dynamic>> fetchProductss() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/productsss'));
    if (response.statusCode == 200) {
      return List<dynamic>.from(json.decode(response.body) as List);
    } else {
      throw Exception('Failed to load products');
    }
  }
  final String baseUrl = "http://127.0.0.1:8000/api";
  Future<List<dynamic>> fetchRestaurantsByProduct(String productName) async {
    final response = await http.get(Uri.parse('$baseUrl/restaurants-by-product?product_name=$productName'));
    if (response.statusCode == 200) {
      return List<dynamic>.from(json.decode(response.body) as List);
    } else {
      throw Exception('Failed to load restaurants by product');
    }
  }
}
