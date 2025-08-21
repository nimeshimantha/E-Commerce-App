import 'package:e_commerce/components/card.dart';
import 'package:e_commerce/models/cart.dart';
import 'package:e_commerce/models/shoe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopState();
}

class _ShopState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => Column(
        children: [
          // Top deals title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text(
                  'Deals',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Horizontal list of shoes
          SizedBox(
            height: 300, // Provide a height constraint for horizontal ListView
            child: ListView.builder(
              itemCount: value.getShoeList().length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              itemBuilder: (context, index) {
                Shoe shoe = value.getShoeList()[index];
                return ShoeTile(
                  shoe: shoe,
                );
              },
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(top: 25.0, left: 25, right: 25),
            child: Divider(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
