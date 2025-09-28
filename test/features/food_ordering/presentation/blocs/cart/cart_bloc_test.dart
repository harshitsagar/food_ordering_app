import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery_app/features/food_ordering/domain/entities/menu_item.dart';
import 'package:food_delivery_app/features/food_ordering/presentation/blocs/cart/cart_bloc.dart';

void main() {
  late CartBloc cartBloc;

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

  final testMenuItem2 = const MenuItem(
    id: '2',
    name: 'Test Item 2',
    description: 'Test description 2',
    price: 14.99,
    imageUrl: 'https://example.com/item2.jpg',
    category: 'Test Category',
    isVegetarian: false,
    isAvailable: true,
  );

  setUp(() {
    cartBloc = CartBloc();
  });

  tearDown(() {
    cartBloc.close();
  });

  group('CartBloc', () {
    test('initial state is CartInitial', () {
      expect(cartBloc.state, isA<CartInitial>());
    });

    blocTest<CartBloc, CartState>(
      'emits CartLoaded when AddToCart is added with new item',
      build: () => cartBloc,
      act: (bloc) => bloc.add(AddToCart(menuItem: testMenuItem)),
      expect: () => [
        isA<CartLoaded>(),
      ],
      verify: (bloc) {
        final state = bloc.state as CartLoaded;
        expect(state.items.length, 1);
        expect(state.items.first.menuItem, testMenuItem);
        expect(state.items.first.quantity, 1);
        expect(state.totalAmount, 12.99);
        expect(state.totalItems, 1);
      },
    );

    blocTest<CartBloc, CartState>(
      'increases quantity when adding same item twice',
      build: () => cartBloc,
      act: (bloc) {
        bloc.add(AddToCart(menuItem: testMenuItem));
        bloc.add(AddToCart(menuItem: testMenuItem));
      },
      expect: () => [
        isA<CartLoaded>(),
        isA<CartLoaded>(),
      ],
      verify: (bloc) {
        final state = bloc.state as CartLoaded;
        expect(state.items.length, 1);
        expect(state.items.first.quantity, 2);
        expect(state.totalAmount, 25.98);
        expect(state.totalItems, 2);
      },
    );

    blocTest<CartBloc, CartState>(
      'adds different items correctly',
      build: () => cartBloc,
      act: (bloc) {
        bloc.add(AddToCart(menuItem: testMenuItem));
        bloc.add(AddToCart(menuItem: testMenuItem2));
      },
      expect: () => [
        isA<CartLoaded>(),
        isA<CartLoaded>(),
      ],
      verify: (bloc) {
        final state = bloc.state as CartLoaded;
        expect(state.items.length, 2);
        expect(state.totalAmount, 27.98);
        expect(state.totalItems, 2);
      },
    );

    blocTest<CartBloc, CartState>(
      'emits CartInitial when last item is removed',
      build: () => cartBloc,
      act: (bloc) {
        bloc.add(AddToCart(menuItem: testMenuItem));
        bloc.add(RemoveFromCart(menuItemId: testMenuItem.id));
      },
      expect: () => [
        isA<CartLoaded>(),
        isA<CartInitial>(),
      ],
    );

    blocTest<CartBloc, CartState>(
      'updates quantity correctly',
      build: () => cartBloc,
      act: (bloc) {
        bloc.add(AddToCart(menuItem: testMenuItem));
        bloc.add(UpdateCartItemQuantity(
          menuItemId: testMenuItem.id,
          quantity: 3,
        ));
      },
      expect: () => [
        isA<CartLoaded>(),
        isA<CartLoaded>(),
      ],
      verify: (bloc) {
        final state = bloc.state as CartLoaded;
        expect(state.items.first.quantity, 3);
        expect(state.totalAmount, 38.97);
        expect(state.totalItems, 3);
      },
    );

    blocTest<CartBloc, CartState>(
      'clears cart correctly',
      build: () => cartBloc,
      act: (bloc) {
        bloc.add(AddToCart(menuItem: testMenuItem));
        bloc.add(AddToCart(menuItem: testMenuItem2));
        bloc.add(ClearCart());
      },
      expect: () => [
        isA<CartLoaded>(),
        isA<CartLoaded>(),
        isA<CartInitial>(),
      ],
      verify: (bloc) {
        expect(bloc.state, isA<CartInitial>());
      },
    );

    blocTest<CartBloc, CartState>(
      'removes item when quantity is decreased to 0',
      build: () => cartBloc,
      act: (bloc) {
        bloc.add(AddToCart(menuItem: testMenuItem));
        bloc.add(UpdateCartItemQuantity(
          menuItemId: testMenuItem.id,
          quantity: 0,
        ));
      },
      expect: () => [
        isA<CartLoaded>(),
        isA<CartInitial>(),
      ],
    );
  });
}