import 'dart:convert';

import 'package:flutter_amazon_clone/models/rating.dart';

class Product {
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String category;
  final List<String> images;
  final String? id;
  final String? userId;
  final List<Rating>? rating;

  Product(
      {required this.name,
      required this.description,
      required this.price,
      required this.quantity,
      required this.category,
      required this.images,
      this.id,
      this.userId,
      this.rating});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'category': category,
      'images': images,
      'id': id,
      'userId': userId,
      "rating": rating
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toInt() ?? 0,
      category: map['category'] ?? '',
      images: List<String>.from(map['images']),
      id: map['_id'] ?? '',
      userId: map['userId'] ?? '',
      rating: map['ratings'] != null
          ? List<Rating>.from(
              map["ratings"]?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
