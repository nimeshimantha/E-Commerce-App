import 'package:e_commerce/models/shoe.dart';
import 'package:flutter/material.dart';

class ShoeTile extends StatelessWidget {
  final Shoe shoe;  // Made final since it's a StatelessWidget
  const ShoeTile({super.key, required this.shoe});

  @override
  Widget build(BuildContext context) {
    // Actual implementation using the shoe parameter
    return Container(
      margin: EdgeInsets.only(left: 25),
      width: 200,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          //shoe pic
          Image.asset(shoe.imagePath),
          //name
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                 Text(shoe.name,
          style: TextStyle(color: Colors.black),),
           Text(shoe.price,
          style: TextStyle(color: Colors.black),),
         Container(
          padding:const EdgeInsets.all(10),
          decoration:const BoxDecoration(color: Colors.black),
          child: const  Icon(Icons.add, color: Colors.white,),
         )
              ],
            ),
          ],
         )
          //pric
          //add button
        ],
      ),
    );
  }
}