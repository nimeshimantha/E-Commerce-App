import 'package:e_commerce/components/nav.dart';
import 'package:e_commerce/pages/cart.dart';
import 'package:e_commerce/pages/categories.dart';
import 'package:e_commerce/pages/profile.dart';
import 'package:e_commerce/pages/shop.dart';
import 'package:e_commerce/pages/wishlist.dart';
import 'package:e_commerce/theme/app_theme.dart';
import 'package:flutter/material.dart';

class Dash extends StatefulWidget {
  const Dash({super.key});

  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {
  int _selectedIndex = 0;

  void navigationBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final pages = [
      ShopPage(onNavigateTab: navigationBottomBar),
      CategoriesPage(
        onNavigateToHomeWithCategory: (idx) => navigationBottomBar(0),
      ),
      WishlistPage(
        onBrowseProducts: () => navigationBottomBar(0),
      ),
      CartPage(
        onBrowseProducts: () => navigationBottomBar(0),
      ),
      const ProfilePage(),
    ];

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      bottomNavigationBar: Nav(
        selectedIndex: _selectedIndex,
        onTabChange: navigationBottomBar,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
    );
  }
}
