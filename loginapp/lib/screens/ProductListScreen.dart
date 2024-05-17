import 'package:flutter/material.dart';
import 'ApiService.dart';
import 'RestaurantsByProductScreen.dart';
class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ApiService _apiService = ApiService();
  List<dynamic> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts() async {
    try {
      _products = await _apiService.fetchProductss(); // Make sure this is corrected to the actual method name
      setState(() {});
    } catch (e) {
      print('Error loading products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Product'),
      ),
      body: _products.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_products[index]['name']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RestaurantsByProductScreen(productName: _products[index]['name']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
