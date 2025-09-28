import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/features/food_ordering/presentation/blocs/resturant/restaurant_bloc.dart';
import 'package:food_delivery_app/features/food_ordering/presentation/widgets/restaurant_card.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocBuilder<RestaurantBloc, RestaurantState>(
        builder: (context, state) {
          if (state is RestaurantLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RestaurantError) {
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
                      context.read<RestaurantBloc>().add(LoadRestaurants());
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          } else if (state is RestaurantLoaded) {
            return ListView.builder(
              itemCount: state.restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = state.restaurants[index];
                return RestaurantCard(
                  restaurant: restaurant,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/restaurant-menu',
                      arguments: restaurant.id,
                    );
                  },
                );
              },
            );
          } else {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<RestaurantBloc>().add(LoadRestaurants());
                },
                child: const Text('Load Restaurants'),
              ),
            );
          }
        },
      ),
    );
  }
}