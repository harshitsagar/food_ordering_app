import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/features/food_ordering/presentation/blocs/menu/menu_bloc.dart';
import 'package:food_delivery_app/features/food_ordering/presentation/blocs/cart/cart_bloc.dart';
import 'package:food_delivery_app/features/food_ordering/presentation/widgets/menu_item_card.dart';

class RestaurantMenuPage extends StatelessWidget {
  final String restaurantId;

  const RestaurantMenuPage({
    super.key,
    required this.restaurantId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<MenuBloc, MenuState>(
          builder: (context, state) {
            if (state is MenuLoaded) {
              return Text(state.restaurant.name);
            }
            return const Text('Menu');
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) {
          if (state is MenuLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MenuError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<MenuBloc>().add(
                        LoadMenuItems(restaurantId: restaurantId),
                      );
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          } else if (state is MenuLoaded) {
            return Column(
              children: [
                // Restaurant info card
                Card(
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.restaurant.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.restaurant.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(state.restaurant.rating.toString()),
                            const SizedBox(width: 16),
                            Icon(
                              Icons.access_time,
                              color: Colors.grey[600],
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(state.restaurant.deliveryTime),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.menuItems.length,
                    itemBuilder: (context, index) {
                      final menuItem = state.menuItems[index];
                      return MenuItemCard(menuItem: menuItem);
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('No menu items available'),
            );
          }
        },
      ),
      floatingActionButton: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.totalItems > 0) {
            return FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
              icon: const Icon(Icons.shopping_cart),
              label: Text('Cart (${state.totalItems})'),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}