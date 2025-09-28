import 'package:get_it/get_it.dart';
import 'package:food_delivery_app/features/food_ordering/domain/repositories/restaurant_repository.dart';
import 'package:food_delivery_app/features/food_ordering/data/repositories/restaurant_repository_impl.dart';

final getIt = GetIt.instance;

void setupFoodOrderingDependencies() {
  getIt.registerLazySingleton<RestaurantRepository>(
        () => RestaurantRepositoryImpl(),
  );
}