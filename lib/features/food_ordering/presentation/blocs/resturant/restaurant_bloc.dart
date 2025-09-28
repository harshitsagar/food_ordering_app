import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/features/food_ordering/domain/entities/restaurant.dart';
import 'package:food_delivery_app/features/food_ordering/domain/repositories/restaurant_repository.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository restaurantRepository;

  RestaurantBloc({required this.restaurantRepository})
      : super(RestaurantInitial()) {
    on<LoadRestaurants>(_onLoadRestaurants);
  }

  Future<void> _onLoadRestaurants(
      LoadRestaurants event,
      Emitter<RestaurantState> emit,
      ) async {
    emit(RestaurantLoading());
    try {
      final restaurants = await restaurantRepository.getRestaurants();
      emit(RestaurantLoaded(restaurants: restaurants));
    } catch (e) {
      emit(RestaurantError(message: 'Failed to load restaurants: $e'));
    }
  }
}