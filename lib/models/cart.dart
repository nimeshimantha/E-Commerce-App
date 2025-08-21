import 'package:e_commerce/models/shoe.dart';
import 'package:flutter/material.dart';

class Cart extends ChangeNotifier {
  // Initial list of shoes available in the shop
  final List<Shoe> shoeShop = [
    Shoe(
      imagePath: 'lib/images/3.png',
      name: 'Black Mist',
      price: '220',
    ),
    Shoe(
      imagePath: 'lib/images/4.png',
      name: 'Shadow Runner',
      price: '200',
    ),
    Shoe(
      imagePath: 'lib/images/5.png',
      name: 'Crimson Blaze',
      price: '290',
    ),
    Shoe(
      imagePath: 'lib/images/6.png',
      name: 'Galaxy Drip',
      price: '670',
    ),
    Shoe(
      imagePath: 'lib/images/7.jpg',
      name: 'Sky Walker',
      price: '560',
    ),
  ];

  // List of items added to the user's cart
  final List<Shoe> userCart = [];

  // Getter to access shop items
  List<Shoe> getShoeList() {
    return shoeShop;
  }

  // Getter to access cart items
  List<Shoe> getUserCart() {
    return userCart;
  }

  // Add item to cart
  void addItemToCart(Shoe shoe) {
    userCart.add(shoe);
    notifyListeners();
  }

  // Remove item from cart
  void removeItemFromCart(Shoe shoe) {
    userCart.remove(shoe);
    notifyListeners();
  }
}
