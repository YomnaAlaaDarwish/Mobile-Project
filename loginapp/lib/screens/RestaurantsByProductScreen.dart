import 'package:flutter/material.dart';
import 'ApiService.dart';

class RestaurantsByProductScreen extends StatefulWidget {
  final String productName;

  RestaurantsByProductScreen({required this.productName});

  @override
  _RestaurantsByProductScreenState createState() => _RestaurantsByProductScreenState();
}

class _RestaurantsByProductScreenState extends State<RestaurantsByProductScreen> {
  final ApiService _apiService = ApiService();
  List<dynamic> _restaurants = [];

  @override
  void initState() {
    super.initState();
    _fetchRestaurants();
  }

  void _fetchRestaurants() async {
    try {
      _restaurants = await _apiService.fetchRestaurantsByProduct(widget.productName);
      setState(() {});
    } catch (e) {
      print('Error loading restaurants: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants Offering ${widget.productName}'),
      ),
      body: ListView.builder(
        itemCount: _restaurants.length,
        itemBuilder: (context, index) {
          var restaurant = _restaurants[index];
          return ListTile(
            title: Text(restaurant['restaurantName']),
            subtitle: Text('Lat: ${restaurant['latitude']}, Long: ${restaurant['longitude']}'),
            trailing: Text(restaurant['type']),
          );
        },
      ),
    );
  }
}
