import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery_app/features/food_ordering/domain/entities/restaurant.dart';
import 'package:food_delivery_app/features/food_ordering/domain/entities/menu_item.dart';
import 'package:food_delivery_app/features/food_ordering/domain/entities/cart_item.dart';
import 'package:food_delivery_app/features/food_ordering/domain/entities/order.dart';

void main() {
  group('Restaurant Entity', () {
    test('should create restaurant with correct properties', () {
      const restaurant = Restaurant(
        id: '1',
        name: 'Test Restaurant',
        imageUrl: 'https://example.com/image.jpg',
        description: 'Test description',
        rating: 4.5,
        deliveryTime: '25-35 min',
        deliveryFee: '\$2.99',
      );

      expect(restaurant.id, '1');
      expect(restaurant.name, 'Test Restaurant');
      expect(restaurant.rating, 4.5);
      expect(restaurant.deliveryTime, '25-35 min');
    });

    test('should be equal when properties are same', () {
      const restaurant1 = Restaurant(
        id: '1',
        name: 'Test Restaurant',
        imageUrl: 'https://example.com/image.jpg',
        description: 'Test description',
        rating: 4.5,
        deliveryTime: '25-35 min',
        deliveryFee: '\$2.99',
      );

      const restaurant2 = Restaurant(
        id: '1',
        name: 'Test Restaurant',
        imageUrl: 'https://example.com/image.jpg',
        description: 'Test description',
        rating: 4.5,
        deliveryTime: '25-35 min',
        deliveryFee: '\$2.99',
      );

      expect(restaurant1, restaurant2);
    });
  });

  group('MenuItem Entity', () {
    test('should create menu item with correct properties', () {
      const menuItem = MenuItem(
        id: '1',
        name: 'Test Item',
        description: 'Test description',
        price: 12.99,
        imageUrl: 'https://example.com/item.jpg',
        category: 'Test Category',
        isVegetarian: true,
        isAvailable: true,
      );

      expect(menuItem.id, '1');
      expect(menuItem.name, 'Test Item');
      expect(menuItem.price, 12.99);
      expect(menuItem.isVegetarian, true);
      expect(menuItem.isAvailable, true);
    });

    test('should copy menu item with new properties', () {
      const originalMenuItem = MenuItem(
        id: '1',
        name: 'Test Item',
        description: 'Test description',
        price: 12.99,
        imageUrl: 'https://example.com/item.jpg',
        category: 'Test Category',
        isVegetarian: true,
        isAvailable: true,
      );

      final copiedMenuItem = originalMenuItem.copyWith(isAvailable: false);

      expect(copiedMenuItem.id, '1');
      expect(copiedMenuItem.name, 'Test Item');
      expect(copiedMenuItem.isAvailable, false);
    });
  });

  group('CartItem Entity', () {
    test('should create cart item with correct properties', () {
      const menuItem = MenuItem(
        id: '1',
        name: 'Test Item',
        description: 'Test description',
        price: 12.99,
        imageUrl: 'https://example.com/item.jpg',
        category: 'Test Category',
        isVegetarian: true,
        isAvailable: true,
      );

      const cartItem = CartItem(menuItem: menuItem, quantity: 2);

      expect(cartItem.menuItem, menuItem);
      expect(cartItem.quantity, 2);
      expect(cartItem.totalPrice, 25.98);
    });

    test('should copy cart item with new properties', () {
      const menuItem = MenuItem(
        id: '1',
        name: 'Test Item',
        description: 'Test description',
        price: 12.99,
        imageUrl: 'https://example.com/item.jpg',
        category: 'Test Category',
        isVegetarian: true,
        isAvailable: true,
      );

      const originalCartItem = CartItem(menuItem: menuItem, quantity: 2);
      final copiedCartItem = originalCartItem.copyWith(quantity: 3);

      expect(copiedCartItem.menuItem, menuItem);
      expect(copiedCartItem.quantity, 3);
      expect(copiedCartItem.totalPrice, 38.97);
    });
  });

  group('Order Entity', () {
    test('should create order with correct properties', () {
      const menuItem = MenuItem(
        id: '1',
        name: 'Test Item',
        description: 'Test description',
        price: 12.99,
        imageUrl: 'https://example.com/item.jpg',
        category: 'Test Category',
        isVegetarian: true,
        isAvailable: true,
      );

      final cartItems = [CartItem(menuItem: menuItem, quantity: 2)];
      final orderDate = DateTime.now();

      final order = Order(
        id: '1',
        restaurantId: '1',
        restaurantName: 'Test Restaurant',
        items: cartItems,
        totalAmount: 25.98,
        orderDate: orderDate,
        status: OrderStatus.confirmed,
      );

      expect(order.id, '1');
      expect(order.restaurantName, 'Test Restaurant');
      expect(order.items, cartItems);
      expect(order.totalAmount, 25.98);
      expect(order.status, OrderStatus.confirmed);
    });
  });
}