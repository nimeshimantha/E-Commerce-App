import 'package:e_commerce/models/shoe.dart';

class CartItem {
  final Shoe shoe;
  int quantity;
  String selectedSize;
  String selectedColor;

  CartItem({
    required this.shoe,
    this.quantity = 1,
    this.selectedSize = 'US 9',
    this.selectedColor = '#111827',
  });

  double get totalPrice => shoe.priceValue * quantity;

  CartItem copyWith({
    Shoe? shoe,
    int? quantity,
    String? selectedSize,
    String? selectedColor,
  }) {
    return CartItem(
      shoe: shoe ?? this.shoe,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shoe': shoe.toMap(),
      'quantity': quantity,
      'selectedSize': selectedSize,
      'selectedColor': selectedColor,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      shoe: Shoe.fromMap(map['shoe'] as Map<String, dynamic>),
      quantity: (map['quantity'] as num?)?.toInt() ?? 1,
      selectedSize: map['selectedSize'] as String? ?? 'US 9',
      selectedColor: map['selectedColor'] as String? ?? '#111827',
    );
  }
}

