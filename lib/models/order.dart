import 'package:e_commerce/models/cart_item.dart';

enum OrderStatus { pending, confirmed, processing, shipped, delivered, cancelled }

class OrderModel {
  final String id;
  final DateTime date;
  final List<CartItem> items;
  final double subtotal;
  final double shipping;
  final double discount;
  final double total;
  final String shippingAddress;
  final String paymentMethod;
  final OrderStatus status;

  OrderModel({
    required this.id,
    required this.date,
    required this.items,
    required this.subtotal,
    required this.shipping,
    required this.discount,
    required this.total,
    required this.shippingAddress,
    required this.paymentMethod,
    this.status = OrderStatus.confirmed,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'items': items.map((e) => e.toMap()).toList(),
      'subtotal': subtotal,
      'shipping': shipping,
      'discount': discount,
      'total': total,
      'shippingAddress': shippingAddress,
      'paymentMethod': paymentMethod,
      'status': status.name,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as String,
      date: DateTime.tryParse(map['date'] as String? ?? '') ?? DateTime.now(),
      items: (map['items'] as List<dynamic>?)
              ?.map((e) => CartItem.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      subtotal: (map['subtotal'] as num?)?.toDouble() ?? 0.0,
      shipping: (map['shipping'] as num?)?.toDouble() ?? 0.0,
      discount: (map['discount'] as num?)?.toDouble() ?? 0.0,
      total: (map['total'] as num?)?.toDouble() ?? 0.0,
      shippingAddress: map['shippingAddress'] as String? ?? '',
      paymentMethod: map['paymentMethod'] as String? ?? 'Credit Card',
      status: OrderStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => OrderStatus.confirmed,
      ),
    );
  }
}

