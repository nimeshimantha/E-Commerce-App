import 'package:e_commerce/main.dart';
import 'package:e_commerce/models/cart.dart';
import 'package:e_commerce/models/shoe.dart';
import 'package:e_commerce/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Elegance Wear App & Model Smoke Tests', () {
    testWidgets('IntroPage smoke test - renders branding and CTA',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.text('ELEGANCE WEAR'), findsOneWidget);
      expect(find.text('Get Started'), findsOneWidget);
      expect(find.text('Continue as Guest'), findsOneWidget);
    });

    test('Shoe Model serialization test (Firestore compatible)', () {
      final shoe = Shoe(
        id: 'test_shoe',
        imagePath: 'lib/images/3.png',
        name: 'Test Runner',
        price: '250',
        category: 'Running',
      );

      final map = shoe.toMap();
      expect(map['id'], 'test_shoe');
      expect(map['name'], 'Test Runner');
      expect(map['price'], '250');

      final reconstructed = Shoe.fromMap(map);
      expect(reconstructed.id, 'test_shoe');
      expect(reconstructed.name, 'Test Runner');
      expect(reconstructed.priceValue, 250.0);
    });

    test('Cart calculations and item operations', () {
      final cart = Cart();
      final sampleShoe = cart.shoeShop.first;

      expect(cart.cartCount, 0);
      expect(cart.subtotal, 0.0);

      // Add 2 items
      cart.addCartItem(sampleShoe, quantity: 2);
      expect(cart.cartCount, 2);
      expect(cart.subtotal, sampleShoe.priceValue * 2);

      // Apply promo
      final promoApplied = cart.applyPromo('ELEGANCE10');
      expect(promoApplied, isTrue);
      expect(cart.discountAmount, cart.subtotal * 0.10);

      // Place order
      final order = cart.placeOrder(
        shippingAddress: '123 Main St',
        paymentMethod: 'Credit Card',
      );

      expect(order, isNotNull);
      expect(cart.cartCount, 0);
      expect(cart.orders.length, 1);
    });

    test('UserProfile sign in and sign out', () {
      final profile = UserProfile();
      expect(profile.isSignedIn, isFalse);

      profile.setUser(name: 'Jane Doe', email: 'jane@example.com');
      expect(profile.isSignedIn, isTrue);
      expect(profile.name, 'Jane Doe');
      expect(profile.email, 'jane@example.com');

      profile.signOut();
      expect(profile.isSignedIn, isFalse);
    });
  });
}
