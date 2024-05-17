import 'package:flutter/material.dart';
import 'ApiService.dart';
class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ApiService _apiService = ApiService();
  Map<String, List<String>?> _productsByRestaurant = {};  // Allowing nullable list

  @override
  void initState() {
    super.initState();
    _apiService.fetchProducts().then((data) {
      setState(() {
        // Assuming 'data' is already parsed correctly from JSON and is Map<String, dynamic>
        _productsByRestaurant = data.map((key, value) => MapEntry(key, List<String>.from(value ?? [])));
      });
    }).catchError((e) {
      print("Failed to load products: $e");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products by Restaurant'),
      ),
      body: ListView.builder(
        itemCount: _productsByRestaurant.length,
        itemBuilder: (context, index) {
          String restaurant = _productsByRestaurant.keys.elementAt(index);
          List<String> products = _productsByRestaurant[restaurant] ?? [];  // Default to empty list if null
          return ListTile(
            title: Text('$restaurant has products:'),
            subtitle: Text(products.join(', ')), // Displaying products or an empty message
          );
        },
      ),
    );
  }
}


