import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/features/food_ordering/domain/entities/menu_item.dart';
import 'package:food_delivery_app/features/food_ordering/domain/repositories/restaurant_repository.dart';

import '../../../domain/entities/restaurant.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final RestaurantRepository restaurantRepository;

  MenuBloc({required this.restaurantRepository}) : super(MenuInitial()) {
    on<LoadMenuItems>(_onLoadMenuItems);
  }

  Future<void> _onLoadMenuItems(
      LoadMenuItems event,
      Emitter<MenuState> emit,
      ) async {
    emit(MenuLoading());
    try {
      final menuItems = await restaurantRepository.getMenuItems(event.restaurantId);
      final restaurant = await restaurantRepository.getRestaurantById(event.restaurantId);
      emit(MenuLoaded(
        menuItems: menuItems,
        restaurant: restaurant,
      ));
    } catch (e) {
      emit(MenuError(message: 'Failed to load menu: $e'));
    }
  }
}