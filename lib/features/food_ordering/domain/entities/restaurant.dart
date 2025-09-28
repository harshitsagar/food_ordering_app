import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final double rating;
  final String deliveryTime;
  final String deliveryFee;

  const Restaurant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.rating,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    imageUrl,
    description,
    rating,
    deliveryTime,
    deliveryFee,
  ];
}