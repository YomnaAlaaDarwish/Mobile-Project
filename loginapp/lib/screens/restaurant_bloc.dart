import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'restaurant_event.dart';
import 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(RestaurantLoading()) {
    on<LoadRestaurants>(_onLoadRestaurants);
    on<AddRestaurant>(_onAddRestaurant);
  }

  Future<void> _onLoadRestaurants(LoadRestaurants event, Emitter<RestaurantState> emit) async {
    emit(RestaurantLoading());
    try {
      // Simulate fetching data from an API
      List<dynamic> restaurants = await fetchRestaurants();
      emit(RestaurantLoaded(restaurants));
    } catch (e) {
      emit(RestaurantError("Failed to load restaurants: ${e.toString()}"));
    }
  }

  Future<void> _onAddRestaurant(AddRestaurant event, Emitter<RestaurantState> emit) async {
    try {
      // Simulate adding a restaurant through an API
      dynamic newRestaurant = await addRestaurant(event.restaurantData);
      List<dynamic> updatedRestaurants = (state as RestaurantLoaded).restaurants..add(newRestaurant);
      emit(RestaurantLoaded(updatedRestaurants));
    } catch (e) {
      emit(RestaurantError("Failed to add restaurant"));
    }
  }

  // // Dummy API call for fetching restaurants
  // Future<List<dynamic>> fetchRestaurants() async {
  //   return [
  //     {'name': 'Cafe Good Life', 'latitude': 40.712776, 'longitude': -74.005974, 'type': 'Cafe'},
  //     // Add more dummy data
  //   ];
  // }
  //
  // // Dummy API call for adding a restaurant
  // Future<dynamic> addRestaurant(Map<String, dynamic> restaurantData) async {
  //   return restaurantData;  // In a real scenario, this would return data from an API call
  // }

  Future<List<dynamic>> fetchRestaurants() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/list'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  Future<dynamic> addRestaurant(Map<String, dynamic> restaurantData) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/store'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(restaurantData),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add restaurant');
    }
  }

}
