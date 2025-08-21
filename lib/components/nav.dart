import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Nav extends StatelessWidget {
  final void Function(int)? onTabChange;

  const Nav({
    super.key,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GNav(
        activeColor: Colors.grey.shade900,
        tabActiveBorder: Border.all(color: Colors.white),
        tabBackgroundColor: Colors.grey.shade100,
        mainAxisAlignment: MainAxisAlignment.center,
        onTabChange: onTabChange,
        tabs: const [
          GButton(icon: Icons.home, text: 'Shop'),
          GButton(icon: Icons.shopping_bag_rounded, text: 'Cart'),
          GButton(icon: Icons.person, text: 'Profile'),
        ],
      ),
    );
  }
}
