import 'package:e_commerce/components/app_image.dart';
import 'package:e_commerce/components/empty_state.dart';
import 'package:e_commerce/models/cart.dart';
import 'package:e_commerce/pages/product_details.dart';
import 'package:e_commerce/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatelessWidget {
  final VoidCallback? onBrowseProducts;

  const WishlistPage({super.key, this.onBrowseProducts});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text('Wishlist (${cart.wishlistCount})'),
        backgroundColor:
            isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        elevation: 0,
      ),
      body: cart.wishlist.isEmpty
          ? EmptyState(
              icon: Icons.favorite_border_rounded,
              title: 'Your Wishlist is Empty',
              message:
                  'Explore our collection and tap the heart icon on any pair you love to save them here.',
              buttonText: 'Start Shopping',
              onButtonPressed: onBrowseProducts,
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: cart.wishlist.length,
              itemBuilder: (context, index) {
                final shoe = cart.wishlist[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color:
                        isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color:
                          isDark ? AppColors.borderDark : AppColors.borderLight,
                    ),
                    boxShadow: AppShadows.cardSm,
                  ),
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
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          // Thumbnail
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.surfaceVariantDark
                                  : AppColors.surfaceVariantLight,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: AppImage(
                              imagePath: shoe.imagePath,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(width: 14),

                          // Shoe details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  shoe.category.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.secondary,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                                const SizedBox(height: 4),
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
                                const SizedBox(height: 6),
                                Text(
                                  '\$${shoe.price}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: isDark
                                        ? AppColors.textPrimaryDark
                                        : AppColors.textPrimaryLight,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Action Buttons
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.favorite,
                                    color: AppColors.error, size: 22),
                                onPressed: () {
                                  cart.toggleWishlist(shoe);
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.add_shopping_cart_rounded,
                                  color: AppColors.primary,
                                  size: 22,
                                ),
                                onPressed: () {
                                  cart.addCartItem(shoe);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                          '${shoe.name} added to your cart'),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

