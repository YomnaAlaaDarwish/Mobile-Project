// restaurant_state.dart

abstract class RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantLoaded extends RestaurantState {
  final List<dynamic> restaurants;
  RestaurantLoaded(this.restaurants);
}

class RestaurantError extends RestaurantState {
  final String message;
  RestaurantError(this.message);
}
