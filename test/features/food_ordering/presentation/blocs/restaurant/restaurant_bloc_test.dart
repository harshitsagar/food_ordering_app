import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery_app/features/food_ordering/presentation/blocs/resturant/restaurant_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:food_delivery_app/features/food_ordering/domain/entities/restaurant.dart';
import 'package:food_delivery_app/features/food_ordering/domain/repositories/restaurant_repository.dart';


class MockRestaurantRepository extends Mock implements RestaurantRepository {}

void main() {
  late MockRestaurantRepository mockRestaurantRepository;
  late RestaurantBloc restaurantBloc;

  final mockRestaurants = [
    const Restaurant(
      id: '1',
      name: 'Test Restaurant 1',
      imageUrl: 'https://example.com/image1.jpg',
      description: 'Test description 1',
      rating: 4.5,
      deliveryTime: '25-35 min',
      deliveryFee: '\$2.99',
    ),
    const Restaurant(
      id: '2',
      name: 'Test Restaurant 2',
      imageUrl: 'https://example.com/image2.jpg',
      description: 'Test description 2',
      rating: 4.3,
      deliveryTime: '20-30 min',
      deliveryFee: '\$1.99',
    ),
  ];

  setUp(() {
    mockRestaurantRepository = MockRestaurantRepository();
    restaurantBloc = RestaurantBloc(restaurantRepository: mockRestaurantRepository);
  });

  tearDown(() {
    restaurantBloc.close();
  });

  group('RestaurantBloc', () {
    test('initial state is RestaurantInitial', () {
      expect(restaurantBloc.state, isA<RestaurantInitial>());
    });

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantLoaded] when LoadRestaurants is successful',
      build: () {
        when(() => mockRestaurantRepository.getRestaurants())
            .thenAnswer((_) async => mockRestaurants);
        return restaurantBloc;
      },
      act: (bloc) => bloc.add(LoadRestaurants()),
      expect: () => [
        RestaurantLoading(),
        RestaurantLoaded(restaurants: mockRestaurants),
      ],
      verify: (_) {
        verify(() => mockRestaurantRepository.getRestaurants()).called(1);
      },
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantError] when LoadRestaurants fails',
      build: () {
        when(() => mockRestaurantRepository.getRestaurants())
            .thenThrow(Exception('Failed to load restaurants'));
        return restaurantBloc;
      },
      act: (bloc) => bloc.add(LoadRestaurants()),
      expect: () => [
        RestaurantLoading(),
        RestaurantError(message: 'Failed to load restaurants: Exception: Failed to load restaurants'),
      ],
      verify: (_) {
        verify(() => mockRestaurantRepository.getRestaurants()).called(1);
      },
    );
  });
}