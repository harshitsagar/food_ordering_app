import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/features/food_ordering/domain/entities/cart_item.dart';
import 'package:food_delivery_app/features/food_ordering/domain/entities/menu_item.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateCartItemQuantity>(_onUpdateCartItemQuantity);
    on<ClearCart>(_onClearCart);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final existingItemIndex = currentState.items.indexWhere(
            (item) => item.menuItem.id == event.menuItem.id,
      );

      List<CartItem> updatedItems;

      if (existingItemIndex != -1) {
        // Update quantity if item exists
        updatedItems = List.from(currentState.items);
        final existingItem = updatedItems[existingItemIndex];
        updatedItems[existingItemIndex] = existingItem.copyWith(
          quantity: existingItem.quantity + 1,
        );
      } else {
        // Add new item
        updatedItems = [
          ...currentState.items,
          CartItem(menuItem: event.menuItem, quantity: 1),
        ];
      }

      emit(CartLoaded(items: updatedItems));
    } else {
      emit(CartLoaded(items: [CartItem(menuItem: event.menuItem, quantity: 1)]));
    }
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final updatedItems = currentState.items
          .where((item) => item.menuItem.id != event.menuItemId)
          .toList();

      if (updatedItems.isEmpty) {
        emit(CartInitial());
      } else {
        emit(CartLoaded(items: updatedItems));
      }
    }
  }

  void _onUpdateCartItemQuantity(
      UpdateCartItemQuantity event,
      Emitter<CartState> emit,
      ) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;

      if (event.quantity <= 0) {
        // Remove item if quantity is 0 or less
        final updatedItems = currentState.items
            .where((item) => item.menuItem.id != event.menuItemId)
            .toList();

        if (updatedItems.isEmpty) {
          emit(CartInitial());
        } else {
          emit(CartLoaded(items: updatedItems));
        }
      } else {
        // Update quantity
        final updatedItems = currentState.items.map((item) {
          if (item.menuItem.id == event.menuItemId) {
            return item.copyWith(quantity: event.quantity);
          }
          return item;
        }).toList();

        emit(CartLoaded(items: updatedItems));
      }
    }
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(CartInitial());
  }
}