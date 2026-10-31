import 'package:e_commerce/components/product_card.dart';
import 'package:e_commerce/models/shoe.dart';
import 'package:flutter/material.dart';

// Preserved for backward compatibility, now powered by responsive ProductCard
class ShoeTile extends StatelessWidget {
  final Shoe shoe;
  const ShoeTile({super.key, required this.shoe});

  @override
  Widget build(BuildContext context) {
    return ProductCard(
      shoe: shoe,
      width: 220,
    );
  }
}
