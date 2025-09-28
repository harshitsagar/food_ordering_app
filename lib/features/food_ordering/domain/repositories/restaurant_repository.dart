import '../entities/restaurant.dart';
import '../entities/menu_item.dart';

abstract class RestaurantRepository {
  Future<List<Restaurant>> getRestaurants();
  Future<List<MenuItem>> getMenuItems(String restaurantId);
  Future<Restaurant> getRestaurantById(String restaurantId);
}