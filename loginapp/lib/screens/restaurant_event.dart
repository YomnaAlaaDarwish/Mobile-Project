// restaurant_event.dart

abstract class RestaurantEvent {}

class AddRestaurant extends RestaurantEvent {
  final Map<String, dynamic> restaurantData;
  AddRestaurant(this.restaurantData);
}

class LoadRestaurants extends RestaurantEvent {}
