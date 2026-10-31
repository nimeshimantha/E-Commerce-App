import 'package:e_commerce/models/cart_item.dart';
import 'package:e_commerce/models/order.dart';
import 'package:e_commerce/models/shoe.dart';
import 'package:flutter/material.dart';

class Cart extends ChangeNotifier {
  // Initial list of shoes available in the shop with valid images
  final List<Shoe> shoeShop = [
    Shoe(
      id: 'black_mist',
      imagePath: 'lib/images/3.png',
      name: 'Black Mist',
      price: '220',
      originalPrice: '260',
      discountPercent: 15,
      category: 'Running',
      rating: 4.9,
      reviewsCount: 142,
      description:
          'Engineered for maximum endurance and lightweight propulsion. The breathable mesh upper keeps feet cool across long miles.',
      stock: 12,
      sizes: ['US 7', 'US 8', 'US 9', 'US 10', 'US 11'],
    ),
    Shoe(
      id: 'shadow_runner',
      imagePath: 'lib/images/4.png',
      name: 'Shadow Runner',
      price: '200',
      originalPrice: '240',
      discountPercent: 17,
      category: 'Lifestyle',
      rating: 4.8,
      reviewsCount: 98,
      description:
          'Sleek all-black stealth silhouette designed for modern urban street style and all-day walking comfort.',
      stock: 8,
      sizes: ['US 8', 'US 9', 'US 10', 'US 11'],
    ),
    Shoe(
      id: 'crimson_blaze',
      imagePath: 'lib/images/5.png',
      name: 'Crimson Blaze',
      price: '290',
      originalPrice: '320',
      discountPercent: 10,
      category: 'Basketball',
      rating: 4.9,
      reviewsCount: 215,
      description:
          'Explosive energy return with dynamic ankle support and high-traction rubber outsole designed for swift lateral cuts.',
      stock: 14,
      sizes: ['US 7.5', 'US 8.5', 'US 9.5', 'US 10.5', 'US 11.5'],
    ),
    Shoe(
      id: 'galaxy_drip',
      // Fixed: previously referenced missing 6.png; now uses existing 2.png
      imagePath: 'lib/images/2.png',
      name: 'Galaxy Drip',
      price: '270',
      originalPrice: '300',
      discountPercent: 10,
      category: 'Lifestyle',
      rating: 4.7,
      reviewsCount: 89,
      description:
          'Futuristic aesthetics paired with responsive midsole foam for an unmatched walking sensation and bold presentation.',
      stock: 6,
      sizes: ['US 7', 'US 8', 'US 9', 'US 10'],
    ),
    Shoe(
      id: 'sky_walker',
      // Fixed: previously referenced missing 7.jpg; now uses existing front.png
      imagePath: 'lib/images/front.png',
      name: 'Sky Walker',
      price: '260',
      originalPrice: '290',
      discountPercent: 10,
      category: 'Training',
      rating: 4.8,
      reviewsCount: 164,
      description:
          'Ultra-stable base built for versatile gym training, cross-fit sessions, and everyday athletic performance.',
      stock: 10,
      sizes: ['US 8', 'US 9', 'US 10', 'US 11', 'US 12'],
    ),
  ];

  // List of items added to the user's cart (legacy compatibility)
  final List<Shoe> userCart = [];

  // Modern structured cart items list with quantity & options
  final List<CartItem> _cartItems = [];

  // Wishlist
  final List<Shoe> _wishlist = [];

  // Order history
  final List<OrderModel> _orders = [];

  // Promo code
  String? _appliedPromo;
  double _promoDiscountRate = 0.0;

  // Selected category filter
  String _selectedCategory = 'All';
  String _searchQuery = '';

  // Getters
  List<Shoe> getShoeList() => shoeShop;
  List<Shoe> getUserCart() => userCart;
  List<CartItem> get cartItems => List.unmodifiable(_cartItems);
  List<Shoe> get wishlist => List.unmodifiable(_wishlist);
  List<OrderModel> get orders => List.unmodifiable(_orders);
  String? get appliedPromo => _appliedPromo;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  int get cartCount =>
      _cartItems.fold(0, (sum, item) => sum + item.quantity);

  int get wishlistCount => _wishlist.length;

  List<String> get categories => [
        'All',
        'Running',
        'Lifestyle',
        'Basketball',
        'Training',
      ];

  List<Shoe> get filteredShoes {
    return shoeShop.where((shoe) {
      final matchesCategory = _selectedCategory == 'All' ||
          shoe.category.toLowerCase() == _selectedCategory.toLowerCase();
      final matchesSearch = _searchQuery.isEmpty ||
          shoe.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          shoe.category.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Legacy cart methods (preserved for backward compatibility)
  void addItemToCart(Shoe shoe) {
    userCart.add(shoe);
    addCartItem(shoe);
  }

  void removeItemFromCart(Shoe shoe) {
    userCart.remove(shoe);
    final idx = _cartItems.indexWhere((item) => item.shoe.name == shoe.name);
    if (idx != -1) {
      if (_cartItems[idx].quantity > 1) {
        _cartItems[idx].quantity--;
      } else {
        _cartItems.removeAt(idx);
      }
    }
    notifyListeners();
  }

  // Modern cart methods
  void addCartItem(Shoe shoe, {int quantity = 1, String? size, String? color}) {
    final chosenSize = size ?? (shoe.sizes.isNotEmpty ? shoe.sizes.first : 'US 9');
    final chosenColor = color ?? (shoe.colors.isNotEmpty ? shoe.colors.first : '#111827');

    final existingIndex = _cartItems.indexWhere(
      (item) =>
          item.shoe.name == shoe.name &&
          item.selectedSize == chosenSize &&
          item.selectedColor == chosenColor,
    );

    if (existingIndex != -1) {
      _cartItems[existingIndex].quantity += quantity;
    } else {
      _cartItems.add(
        CartItem(
          shoe: shoe,
          quantity: quantity,
          selectedSize: chosenSize,
          selectedColor: chosenColor,
        ),
      );
    }

    if (!userCart.contains(shoe)) {
      userCart.add(shoe);
    }

    notifyListeners();
  }

  void updateItemQuantity(CartItem item, int delta) {
    final index = _cartItems.indexOf(item);
    if (index != -1) {
      final newQuantity = _cartItems[index].quantity + delta;
      if (newQuantity <= 0) {
        _cartItems.removeAt(index);
        userCart.remove(item.shoe);
      } else {
        _cartItems[index].quantity = newQuantity;
      }
      notifyListeners();
    }
  }

  void removeCartItem(CartItem item) {
    _cartItems.remove(item);
    userCart.remove(item.shoe);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    userCart.clear();
    _appliedPromo = null;
    _promoDiscountRate = 0.0;
    notifyListeners();
  }

  // Wishlist methods
  bool isInWishlist(Shoe shoe) {
    return _wishlist.any((s) => s.name == shoe.name);
  }

  void toggleWishlist(Shoe shoe) {
    final index = _wishlist.indexWhere((s) => s.name == shoe.name);
    if (index != -1) {
      _wishlist.removeAt(index);
      shoe.isFavorite = false;
    } else {
      _wishlist.add(shoe);
      shoe.isFavorite = true;
    }
    notifyListeners();
  }

  // Financial calculations
  double get subtotal {
    return _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  double get shippingFee {
    if (subtotal == 0) return 0.0;
    return subtotal > 300 ? 0.0 : 15.0; // Free shipping over $300
  }

  double get discountAmount {
    return subtotal * _promoDiscountRate;
  }

  double get totalAmount {
    if (subtotal == 0) return 0.0;
    return subtotal - discountAmount + shippingFee;
  }

  bool applyPromo(String code) {
    final trimmed = code.trim().toUpperCase();
    if (trimmed == 'ELEGANCE10') {
      _appliedPromo = 'ELEGANCE10 (10% OFF)';
      _promoDiscountRate = 0.10;
      notifyListeners();
      return true;
    } else if (trimmed == 'VIP20') {
      _appliedPromo = 'VIP20 (20% OFF)';
      _promoDiscountRate = 0.20;
      notifyListeners();
      return true;
    }
    return false;
  }

  void removePromo() {
    _appliedPromo = null;
    _promoDiscountRate = 0.0;
    notifyListeners();
  }

  // Orders
  OrderModel? placeOrder({
    required String shippingAddress,
    required String paymentMethod,
  }) {
    if (_cartItems.isEmpty) return null;

    final order = OrderModel(
      id: 'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      date: DateTime.now(),
      items: List.from(_cartItems),
      subtotal: subtotal,
      shipping: shippingFee,
      discount: discountAmount,
      total: totalAmount,
      shippingAddress: shippingAddress,
      paymentMethod: paymentMethod,
      status: OrderStatus.confirmed,
    );

    _orders.insert(0, order);
    clearCart();
    return order;
  }
}
