import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/features/food_ordering/domain/entities/cart_item.dart';
import 'package:food_delivery_app/features/food_ordering/domain/entities/order.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<PlaceOrder>(_onPlaceOrder);
  }

  Future<void> _onPlaceOrder(
      PlaceOrder event,
      Emitter<OrderState> emit,
      ) async {
    emit(OrderLoading());

    try {
      // Check for empty items immediately
      if (event.items.isEmpty) {
        emit(OrderError(message: 'Cannot place an empty order'));
        return;
      }

      // Simulate API call delay - use a very short delay for tests
      await Future.delayed(const Duration(milliseconds: 10));

      // Create the order
      final order = Order(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        restaurantId: event.restaurantId,
        restaurantName: event.restaurantName,
        items: List.from(event.items), // Create a new list to avoid reference issues
        totalAmount: event.totalAmount,
        orderDate: DateTime.now(),
        status: OrderStatus.confirmed,
      );

      emit(OrderPlaced(order: order));
    } catch (e) {
      emit(OrderError(message: 'Failed to place order: $e'));
    }
  }
}