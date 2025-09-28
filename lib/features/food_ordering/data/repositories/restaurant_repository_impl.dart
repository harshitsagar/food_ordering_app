import 'package:food_delivery_app/features/food_ordering/domain/entities/restaurant.dart';
import 'package:food_delivery_app/features/food_ordering/domain/entities/menu_item.dart';
import 'package:food_delivery_app/features/food_ordering/domain/repositories/restaurant_repository.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  @override
  Future<List<Restaurant>> getRestaurants() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      Restaurant(
        id: '1',
        name: 'Bella Napoli',
        imageUrl: 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/03/f9/36/02/bella-napoli-130-madison.jpg?w=800&h=500&s=1',
        description: 'Authentic Italian cuisine with fresh ingredients',
        rating: 4.5,
        deliveryTime: '25-35 min',
        deliveryFee: '\$2.99',
      ),
      Restaurant(
        id: '2',
        name: 'Burger Palace',
        imageUrl: 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=400&h=300&fit=crop',
        description: 'Gourmet burgers and crispy fries',
        rating: 4.3,
        deliveryTime: '20-30 min',
        deliveryFee: '\$1.99',
      ),
      Restaurant(
        id: '3',
        name: 'Sushi Zen',
        imageUrl: 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=400&h=300&fit=crop',
        description: 'Fresh sushi and Japanese specialties',
        rating: 4.7,
        deliveryTime: '30-40 min',
        deliveryFee: '\$3.99',
      ),
      Restaurant(
        id: '4',
        name: 'Mexican Fiesta',
        imageUrl: 'https://api.pizzahut.io/v1/content/en-in/in-1/images/pizza/mexican-fiesta.cd946a57e6c57c80adb6380aaf9bb7cb.1.jpg',
        description: 'Spicy Mexican flavors and fresh tacos',
        rating: 4.4,
        deliveryTime: '25-35 min',
        deliveryFee: '\$2.49',
      ),
      Restaurant(
        id: '5',
        name: 'Pizza Heaven',
        imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400&h=300&fit=crop',
        description: 'Wood-fired pizzas with premium toppings',
        rating: 4.6,
        deliveryTime: '30-40 min',
        deliveryFee: '\$3.49',
      ),
      Restaurant(
        id: '6',
        name: 'Asian Wok',
        imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=400&h=300&fit=crop',
        description: 'Authentic Asian stir-fry and noodles',
        rating: 4.4,
        deliveryTime: '25-35 min',
        deliveryFee: '\$2.99',
      ),
    ];
  }

  @override
  Future<List<MenuItem>> getMenuItems(String restaurantId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final menus = {
      '1': [
        MenuItem(
          id: '1-1',
          name: 'Margherita Pizza',
          description: 'Fresh tomato sauce, mozzarella, and basil',
          price: 12.99,
          imageUrl: 'https://images.unsplash.com/photo-1604068549290-dea0e4a305ca?w=400&h=300&fit=crop',
          category: 'Pizza',
          isVegetarian: true,
          isAvailable: true,
        ),
        MenuItem(
          id: '1-2',
          name: 'Pasta Carbonara',
          description: 'Creamy sauce with pancetta and parmesan',
          price: 14.99,
          imageUrl: 'https://leitesculinaria.com/wp-content/uploads/2024/04/spaghetti-carbonara-1200.jpg',
          category: 'Pasta',
          isVegetarian: false,
          isAvailable: true,
        ),
        MenuItem(
          id: '1-3',
          name: 'Tiramisu',
          description: 'Classic Italian dessert with coffee and mascarpone',
          price: 6.99,
          imageUrl: 'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?w=400&h=300&fit=crop',
          category: 'Desserts',
          isVegetarian: true,
          isAvailable: true,
        ),
      ],
      '2': [
        MenuItem(
          id: '2-1',
          name: 'Classic Cheeseburger',
          description: 'Beef patty with cheese, lettuce, and special sauce',
          price: 9.99,
          imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&h=300&fit=crop',
          category: 'Burgers',
          isVegetarian: false,
          isAvailable: true,
        ),
        MenuItem(
          id: '2-2',
          name: 'Crispy Chicken Burger',
          description: 'Fried chicken breast with coleslaw and mayo',
          price: 11.99,
          imageUrl: 'https://www.recipetineats.com/tachyon/2023/09/Crispy-fried-chicken-burgers_5.jpg?resize=900%2C1125&zoom=0.72',
          category: 'Burgers',
          isVegetarian: false,
          isAvailable: true,
        ),
        MenuItem(
          id: '2-3',
          name: 'Loaded Fries',
          description: 'Crispy fries with cheese, bacon, and herbs',
          price: 5.99,
          imageUrl: 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=400&h=300&fit=crop',
          category: 'Sides',
          isVegetarian: true,
          isAvailable: true,
        ),
      ],
      '3': [
        MenuItem(
          id: '3-1',
          name: 'Salmon Sashimi',
          description: 'Fresh salmon slices with wasabi and soy sauce',
          price: 16.99,
          imageUrl: 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=400&h=300&fit=crop',
          category: 'Sashimi',
          isVegetarian: false,
          isAvailable: true,
        ),
        MenuItem(
          id: '3-2',
          name: 'Dragon Roll',
          description: 'Eel, avocado, and cucumber with eel sauce',
          price: 14.99,
          imageUrl: 'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcRAvlggtBdRHY-seAqZy7eAkDggpaaAH4jrylwxMEiPpERBR7mbNjhAWaTqleMmhubLTySRtxtSpFlD_TL56Uz4HsFX_9pRM-BVyyyf3TVLVA',
          category: 'Sushi Rolls',
          isVegetarian: false,
          isAvailable: true,
        ),
        MenuItem(
          id: '3-3',
          name: 'Miso Soup',
          description: 'Traditional Japanese soybean soup',
          price: 3.99,
          imageUrl: 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=400&h=300&fit=crop',
          category: 'Soups',
          isVegetarian: true,
          isAvailable: true,
        ),
      ],
      '4': [
        MenuItem(
          id: '4-1',
          name: 'Beef Tacos',
          description: 'Three soft tacos with seasoned beef and salsa',
          price: 10.99,
          imageUrl: 'https://www.recipetineats.com/tachyon/2018/11/Beef-Tacos_2.jpg?resize=900%2C1125&zoom=0.72',
          category: 'Tacos',
          isVegetarian: false,
          isAvailable: true,
        ),
        MenuItem(
          id: '4-2',
          name: 'Chicken Quesadilla',
          description: 'Grilled tortilla with cheese and chicken',
          price: 8.99,
          imageUrl: 'https://images.unsplash.com/photo-1615870216519-2f9fa575fa5c?w=400&h=300&fit=crop',
          category: 'Quesadillas',
          isVegetarian: false,
          isAvailable: true,
        ),
        MenuItem(
          id: '4-3',
          name: 'Guacamole',
          description: 'Fresh avocado dip with tomatoes and onions',
          price: 5.99,
          imageUrl: 'https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?w=400&h=300&fit=crop',
          category: 'Appetizers',
          isVegetarian: true,
          isAvailable: true,
        ),
      ],
      '5': [
        MenuItem(
          id: '5-1',
          name: 'Pepperoni Pizza',
          description: 'Classic pizza with pepperoni and mozzarella',
          price: 13.99,
          imageUrl: 'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=400&h=300&fit=crop',
          category: 'Pizza',
          isVegetarian: false,
          isAvailable: true,
        ),
        MenuItem(
          id: '5-2',
          name: 'BBQ Chicken Pizza',
          description: 'Grilled chicken with BBQ sauce and red onions',
          price: 15.99,
          imageUrl: 'https://images.unsplash.com/photo-1595708684082-a173bb3a06c5?w=400&h=300&fit=crop',
          category: 'Pizza',
          isVegetarian: false,
          isAvailable: true,
        ),
      ],
      '6': [
        MenuItem(
          id: '6-1',
          name: 'Chicken Fried Rice',
          description: 'Stir-fried rice with chicken and vegetables',
          price: 11.99,
          imageUrl: 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=400&h=300&fit=crop',
          category: 'Rice Dishes',
          isVegetarian: false,
          isAvailable: true,
        ),
        MenuItem(
          id: '6-2',
          name: 'Vegetable Spring Rolls',
          description: 'Crispy rolls with fresh vegetables',
          price: 6.99,
          imageUrl: 'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/04/spring-rolls-vegetable-spring-rolls-1024x1536.webp',
          category: 'Appetizers',
          isVegetarian: true,
          isAvailable: true,
        ),
      ],
    };

    return menus[restaurantId] ?? [];
  }

  @override
  Future<Restaurant> getRestaurantById(String restaurantId) async {
    final restaurants = await getRestaurants();
    return restaurants.firstWhere((restaurant) => restaurant.id == restaurantId);
  }
}