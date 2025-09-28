part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class PlaceOrder extends OrderEvent {
  final String restaurantId;
  final String restaurantName;
  final List<CartItem> items;
  final double totalAmount;

  const PlaceOrder({
    required this.restaurantId,
    required this.restaurantName,
    required this.items,
    required this.totalAmount,
  });

  @override
  List<Object> get props => [restaurantId, restaurantName, items, totalAmount];
}