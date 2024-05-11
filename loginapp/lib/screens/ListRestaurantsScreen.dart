import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'restaurant_bloc.dart'; // Import your BLoC

import 'restaurant_event.dart';
import 'restaurant_state.dart';

class ListRestaurantsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<RestaurantBloc>().add(LoadRestaurants());
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants List'),
      ),
      body: BlocBuilder<RestaurantBloc, RestaurantState>(
        builder: (context, state) {
          if (state is RestaurantLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is RestaurantLoaded) {
            return ListView.builder(
              itemCount: state.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = state.restaurants[index];
                return ListTile(
                  title: Text(restaurant['name']),
                  subtitle: Text('Lat: ${restaurant['latitude']}, Long: ${restaurant['longitude']}'),
                  trailing: Text(restaurant['type']),
                );
              },
            );
          } else if (state is RestaurantError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('Unknown state'));
        },
      ),
    );
  }
}
