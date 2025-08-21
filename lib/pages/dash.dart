import 'package:e_commerce/components/nav.dart';
import 'package:e_commerce/pages/cart.dart';
import 'package:e_commerce/pages/shop.dart';
import 'package:e_commerce/pages/profile.dart';
import 'package:flutter/material.dart';

class Dash extends StatefulWidget {
  const Dash({super.key});

  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const ShopPage(),
    const CartPage(),
    const ProfilePage(),
  ];

  void navigationBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: Nav(onTabChange: navigationBottomBar),
      body: _pages[_selectedIndex],
    );
  }
}
