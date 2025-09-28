import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/features/food_ordering/presentation/blocs/cart/cart_bloc.dart';
import 'package:food_delivery_app/features/food_ordering/presentation/blocs/order/order_bloc.dart';

class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartState = context.read<CartBloc>().state;

    if (cartState is! CartLoaded || cartState.items.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.popUntil(context, (route) => route.isFirst);
      });
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // For demo purposes, use the first item's restaurant
    final restaurantId = cartState.items.first.menuItem.id.split('-').first;
    final restaurantName = _getRestaurantName(restaurantId);

    return BlocProvider(
      create: (context) => OrderBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Order Confirmation'),
          centerTitle: true,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: BlocConsumer<OrderBloc, OrderState>(
          listener: (context, state) {
            if (state is OrderPlaced) {
              // Clear cart after successful order
              context.read<CartBloc>().add(ClearCart());

              // Navigate to success page
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/order-success',
                    (route) => false,
                arguments: state.order,
              );
            }
          },
          builder: (context, state) {
            if (state is OrderLoading) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text(
                      'Placing your order...',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order summary
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Order Summary',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ...cartState.items.map(
                                (item) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${item.menuItem.name} x${item.quantity}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    '\$${item.totalPrice.toStringAsFixed(2)}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\$${cartState.totalAmount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  if (state is OrderError) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red),
                      ),
                      child: Text(
                        state.message,
                        style: TextStyle(
                          color: Colors.red[700],
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state is OrderLoading
                          ? null
                          : () {
                        context.read<OrderBloc>().add(
                          PlaceOrder(
                            restaurantId: restaurantId,
                            restaurantName: restaurantName,
                            items: cartState.items,
                            totalAmount: cartState.totalAmount,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Place Order',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String _getRestaurantName(String restaurantId) {
    switch (restaurantId) {
      case '1':
        return 'Bella Napoli';
      case '2':
        return 'Burger Palace';
      case '3':
        return 'Sushi Zen';
      case '4':
        return 'Mexican Fiesta';
      default:
        return 'Restaurant';
    }
  }
}