import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery_app/features/food_ordering/domain/entities/cart_item.dart';
import 'package:food_delivery_app/features/food_ordering/domain/entities/menu_item.dart';
import 'package:food_delivery_app/features/food_ordering/presentation/blocs/order/order_bloc.dart';

void main() {
  late OrderBloc orderBloc;

  final testMenuItem = const MenuItem(
    id: '1',
    name: 'Test Item',
    description: 'Test description',
    price: 12.99,
    imageUrl: 'https://example.com/item.jpg',
    category: 'Test Category',
    isVegetarian: true,
    isAvailable: true,
  );

  final testCartItems = [
    CartItem(menuItem: testMenuItem, quantity: 2),
  ];

  setUp(() {
    orderBloc = OrderBloc();
  });

  tearDown(() {
    orderBloc.close();
  });

  group('OrderBloc', () {
    test('initial state is OrderInitial', () {
      expect(orderBloc.state, isA<OrderInitial>());
    });

    blocTest<OrderBloc, OrderState>(
      'emits [OrderLoading, OrderPlaced] when PlaceOrder is successful',
      build: () => orderBloc,
      act: (bloc) => bloc.add(PlaceOrder(
        restaurantId: '1',
        restaurantName: 'Test Restaurant',
        items: testCartItems,
        totalAmount: 25.98,
      )),
      wait: const Duration(milliseconds: 50), // Add wait for async operation
      expect: () => [
        OrderLoading(),
        isA<OrderPlaced>(),
      ],
    );

    blocTest<OrderBloc, OrderState>(
      'emits [OrderLoading, OrderError] when items are empty',
      build: () => orderBloc,
      act: (bloc) => bloc.add(PlaceOrder(
        restaurantId: '1',
        restaurantName: 'Test Restaurant',
        items: [],
        totalAmount: 0.0,
      )),
      expect: () => [
        OrderLoading(),
        OrderError(message: 'Cannot place an empty order'),
      ],
    );
  });
}