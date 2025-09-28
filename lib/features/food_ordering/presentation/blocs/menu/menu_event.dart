part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];
}

class LoadMenuItems extends MenuEvent {
  final String restaurantId;

  const LoadMenuItems({required this.restaurantId});

  @override
  List<Object> get props => [restaurantId];
}