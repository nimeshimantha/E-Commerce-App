// models/shoe.dart

class Shoe {
  final String id;
  final String imagePath;
  final String name;
  final String price;
  final String? originalPrice;
  final int discountPercent;
  final String description;
  final String category;
  final double rating;
  final int reviewsCount;
  final int stock;
  final List<String> sizes;
  final List<String> colors;
  bool isFavorite;

  Shoe({
    String? id,
    required this.imagePath,
    required this.name,
    required this.price,
    this.originalPrice,
    this.discountPercent = 0,
    this.description =
        'Engineered with premium cushioning and breathable materials, this shoe delivers all-day comfort and elite performance on any terrain.',
    this.category = 'Sneakers',
    this.rating = 4.8,
    this.reviewsCount = 124,
    this.stock = 15,
    this.sizes = const ['US 7', 'US 8', 'US 9', 'US 10', 'US 11'],
    this.colors = const ['#111827', '#6366F1', '#E2E8F0'],
    this.isFavorite = false,
  }) : id = id ?? name.toLowerCase().replaceAll(' ', '_');

  double get priceValue {
    final cleaned = price.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }

  double? get originalPriceValue {
    if (originalPrice == null) return null;
    final cleaned = originalPrice!.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned);
  }

  Shoe copyWith({
    String? id,
    String? imagePath,
    String? name,
    String? price,
    String? originalPrice,
    int? discountPercent,
    String? description,
    String? category,
    double? rating,
    int? reviewsCount,
    int? stock,
    List<String>? sizes,
    List<String>? colors,
    bool? isFavorite,
  }) {
    return Shoe(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      discountPercent: discountPercent ?? this.discountPercent,
      description: description ?? this.description,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      stock: stock ?? this.stock,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  // Firestore serialization support
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'name': name,
      'price': price,
      'originalPrice': originalPrice,
      'discountPercent': discountPercent,
      'description': description,
      'category': category,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'stock': stock,
      'sizes': sizes,
      'colors': colors,
      'isFavorite': isFavorite,
    };
  }

  factory Shoe.fromMap(Map<String, dynamic> map, {String? docId}) {
    return Shoe(
      id: docId ?? map['id'] as String?,
      imagePath: map['imagePath'] as String? ?? 'lib/images/front.png',
      name: map['name'] as String? ?? 'Shoe',
      price: map['price']?.toString() ?? '0',
      originalPrice: map['originalPrice']?.toString(),
      discountPercent: (map['discountPercent'] as num?)?.toInt() ?? 0,
      description: map['description'] as String? ?? '',
      category: map['category'] as String? ?? 'Sneakers',
      rating: (map['rating'] as num?)?.toDouble() ?? 4.5,
      reviewsCount: (map['reviewsCount'] as num?)?.toInt() ?? 0,
      stock: (map['stock'] as num?)?.toInt() ?? 10,
      sizes: (map['sizes'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const ['US 7', 'US 8', 'US 9', 'US 10', 'US 11'],
      colors: (map['colors'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const ['#111827', '#6366F1'],
      isFavorite: map['isFavorite'] as bool? ?? false,
    );
  }
}
