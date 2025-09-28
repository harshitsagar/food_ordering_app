import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:food_delivery_app/features/food_ordering/domain/entities/restaurant.dart';
import 'package:food_delivery_app/features/food_ordering/domain/entities/menu_item.dart';
import 'package:food_delivery_app/features/food_ordering/domain/repositories/restaurant_repository.dart';
import 'package:food_delivery_app/features/food_ordering/presentation/blocs/menu/menu_bloc.dart';

class MockRestaurantRepository extends Mock implements RestaurantRepository {}

void main() {
  late MockRestaurantRepository mockRestaurantRepository;
  late MenuBloc menuBloc;

  const mockRestaurant = Restaurant(
    id: '1',
    name: 'Test Restaurant',
    imageUrl: 'https://example.com/image.jpg',
    description: 'Test description',
    rating: 4.5,
    deliveryTime: '25-35 min',
    deliveryFee: '\$2.99',
  );

  final mockMenuItems = [
    const MenuItem(
      id: '1-1',
      name: 'Test Item 1',
      description: 'Test description 1',
      price: 12.99,
      imageUrl: 'https://example.com/item1.jpg',
      category: 'Test Category',
      isVegetarian: true,
      isAvailable: true,
    ),
    const MenuItem(
      id: '1-2',
      name: 'Test Item 2',
      description: 'Test description 2',
      price: 14.99,
      imageUrl: 'https://example.com/item2.jpg',
      category: 'Test Category',
      isVegetarian: false,
      isAvailable: true,
    ),
  ];

  setUp(() {
    mockRestaurantRepository = MockRestaurantRepository();
    menuBloc = MenuBloc(restaurantRepository: mockRestaurantRepository);
  });

  tearDown(() {
    menuBloc.close();
  });

  group('MenuBloc', () {
    test('initial state is MenuInitial', () {
      expect(menuBloc.state, isA<MenuInitial>());
    });

    blocTest<MenuBloc, MenuState>(
      'emits [MenuLoading, MenuLoaded] when LoadMenuItems is successful',
      build: () {
        when(() => mockRestaurantRepository.getMenuItems('1'))
            .thenAnswer((_) async => mockMenuItems);
        when(() => mockRestaurantRepository.getRestaurantById('1'))
            .thenAnswer((_) async => mockRestaurant);
        return menuBloc;
      },
      act: (bloc) => bloc.add(LoadMenuItems(restaurantId: '1')),
      expect: () => [
        MenuLoading(),
        MenuLoaded(menuItems: mockMenuItems, restaurant: mockRestaurant),
      ],
      verify: (_) {
        verify(() => mockRestaurantRepository.getMenuItems('1')).called(1);
        verify(() => mockRestaurantRepository.getRestaurantById('1')).called(1);
      },
    );

    blocTest<MenuBloc, MenuState>(
      'emits [MenuLoading, MenuError] when LoadMenuItems fails',
      build: () {
        when(() => mockRestaurantRepository.getMenuItems('1'))
            .thenThrow(Exception('Failed to load menu'));
        when(() => mockRestaurantRepository.getRestaurantById('1'))
            .thenThrow(Exception('Failed to load restaurant'));
        return menuBloc;
      },
      act: (bloc) => bloc.add(LoadMenuItems(restaurantId: '1')),
      expect: () => [
        MenuLoading(),
        MenuError(message: 'Failed to load menu: Exception: Failed to load menu'),
      ],
      verify: (_) {
        verify(() => mockRestaurantRepository.getMenuItems('1')).called(1);
      },
    );
  });
}