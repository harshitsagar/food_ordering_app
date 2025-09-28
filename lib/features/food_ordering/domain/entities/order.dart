import 'package:equatable/equatable.dart';
import 'cart_item.dart';

class Order extends Equatable {
  final String id;
  final String restaurantId;
  final String restaurantName;
  final List<CartItem> items;
  final double totalAmount;
  final DateTime orderDate;
  final OrderStatus status;

  const Order({
    required this.id,
    required this.restaurantId,
    required this.restaurantName,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    restaurantId,
    restaurantName,
    items,
    totalAmount,
    orderDate,
    status,
  ];
}

enum OrderStatus {
  pending,
  confirmed,
  preparing,
  ready,
  delivered,
  cancelled,
}