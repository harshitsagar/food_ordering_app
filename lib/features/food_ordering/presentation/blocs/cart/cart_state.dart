part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  double get totalAmount {
    if (this is CartLoaded) {
      final items = (this as CartLoaded).items;
      return items.fold(0, (total, item) => total + item.totalPrice);
    }
    return 0;
  }

  int get totalItems {
    if (this is CartLoaded) {
      final items = (this as CartLoaded).items;
      return items.fold(0, (total, item) => total + item.quantity);
    }
    return 0;
  }
}

class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoaded extends CartState {
  final List<CartItem> items;

  const CartLoaded({required this.items});

  @override
  List<Object> get props => [items];
}