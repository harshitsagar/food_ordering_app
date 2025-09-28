part of 'menu_bloc.dart';

abstract class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object> get props => [];
}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final List<MenuItem> menuItems;
  final Restaurant restaurant;

  const MenuLoaded({
    required this.menuItems,
    required this.restaurant,
  });

  @override
  List<Object> get props => [menuItems, restaurant];
}

class MenuError extends MenuState {
  final String message;

  const MenuError({required this.message});

  @override
  List<Object> get props => [message];
}