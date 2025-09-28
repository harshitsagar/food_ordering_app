import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/features/food_ordering/domain/entities/order.dart';
import 'package:food_delivery_app/features/food_ordering/food_ordering_injection.dart';
import 'package:food_delivery_app/features/food_ordering/presentation/blocs/cart/cart_bloc.dart';
import 'package:food_delivery_app/features/food_ordering/presentation/blocs/menu/menu_bloc.dart';
import 'package:food_delivery_app/features/food_ordering/presentation/pages/restaurant_list_page.dart';
import 'package:food_delivery_app/features/food_ordering/presentation/pages/restaurant_menu_page.dart';
import 'package:food_delivery_app/features/food_ordering/presentation/pages/cart_page.dart';
import 'package:food_delivery_app/features/food_ordering/presentation/pages/order_confirmation_page.dart';
import 'package:food_delivery_app/features/food_ordering/presentation/pages/order_success_page.dart';
import 'features/food_ordering/domain/repositories/restaurant_repository.dart';
import 'features/food_ordering/presentation/blocs/resturant/restaurant_bloc.dart';

void main() {
  setupFoodOrderingDependencies();
  runApp(const FoodDeliveryApp());
}

class FoodDeliveryApp extends StatelessWidget {
  const FoodDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: getIt<RestaurantRepository>()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<RestaurantBloc>(
            create: (context) => RestaurantBloc(
              restaurantRepository: context.read<RestaurantRepository>(),
            )..add(LoadRestaurants()),
          ),
          BlocProvider<CartBloc>(
            create: (context) => CartBloc(),
          ),
        ],
        child: MaterialApp(
          title: 'Food Delivery App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,
            fontFamily: 'Roboto',
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const RestaurantListPage(),
            '/restaurant-menu': (context) {
              final restaurantId = ModalRoute.of(context)!.settings.arguments as String;
              return BlocProvider(
                create: (context) => MenuBloc(
                  restaurantRepository: context.read<RestaurantRepository>(),
                )..add(LoadMenuItems(restaurantId: restaurantId)),
                child: RestaurantMenuPage(restaurantId: restaurantId),
              );
            },
            '/cart': (context) => const CartPage(),
            '/order-confirmation': (context) => const OrderConfirmationPage(),
            '/order-success': (context) {
              final order = ModalRoute.of(context)!.settings.arguments as Order;
              return OrderSuccessPage(order: order);
            },
          },
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}