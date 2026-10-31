import 'package:e_commerce/components/app_image.dart';
import 'package:e_commerce/models/cart.dart';
import 'package:e_commerce/models/shoe.dart';
import 'package:e_commerce/pages/product_details.dart';
import 'package:e_commerce/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final Shoe shoe;
  final double width;
  final VoidCallback? onAddToCart;

  const ProductCard({
    super.key,
    required this.shoe,
    this.width = 220,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cart = Provider.of<Cart>(context);
    final isFav = cart.isInWishlist(shoe);

    return Container(
      width: width,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
        boxShadow: AppShadows.cardSm,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsPage(shoe: shoe),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Image Container with Badges
              Stack(
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.surfaceVariantDark
                          : AppColors.surfaceVariantLight,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Center(
                      child: Hero(
                        tag: 'shoe_${shoe.id}_card',
                        child: AppImage(
                          imagePath: shoe.imagePath,
                          height: 120,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                  // Discount Badge
                  if (shoe.discountPercent > 0)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.error,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '-${shoe.discountPercent}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                  // Wishlist Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Material(
                      color: (isDark ? AppColors.surfaceDark : Colors.white)
                          .withValues(alpha: 0.9),
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () {
                          cart.toggleWishlist(shoe);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Icon(
                            isFav
                                ? Icons.favorite
                                : Icons.favorite_border_rounded,
                            size: 18,
                            color: isFav ? AppColors.error : AppColors.textMutedLight,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Product Info Body
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Category & Rating
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            shoe.category.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppColors.secondary,
                              letterSpacing: 0.8,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Icon(
                          Icons.star_rounded,
                          size: 14,
                          color: AppColors.accent,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          shoe.rating.toString(),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Product Name
                    Text(
                      shoe.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 10),

                    // Price & Add to Cart Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '\$${shoe.price}',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  color: isDark
                                      ? AppColors.textPrimaryDark
                                      : AppColors.textPrimaryLight,
                                ),
                              ),
                              if (shoe.originalPrice != null)
                                Text(
                                  '\$${shoe.originalPrice}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    decoration: TextDecoration.lineThrough,
                                    color: isDark
                                        ? AppColors.textMutedDark
                                        : AppColors.textMutedLight,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Material(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: onAddToCart ??
                                () {
                                  cart.addItemToCart(shoe);
                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: AppColors.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      content: Row(
                                        children: [
                                          const Icon(Icons.check_circle_rounded,
                                              color: AppColors.success, size: 20),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              '${shoe.name} added to cart',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                },
                            child: const Padding(
                              padding: EdgeInsets.all(9.0),
                              child: Icon(
                                Icons.add_shopping_cart_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
