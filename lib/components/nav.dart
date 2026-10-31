import 'package:e_commerce/models/cart.dart';
import 'package:e_commerce/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Nav extends StatelessWidget {
  final int selectedIndex;
  final void Function(int)? onTabChange;

  const Nav({
    super.key,
    this.selectedIndex = 0,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cart = Provider.of<Cart>(context);

    final items = [
      {'icon': Icons.home_rounded, 'label': 'Home'},
      {'icon': Icons.grid_view_rounded, 'label': 'Categories'},
      {'icon': Icons.favorite_rounded, 'label': 'Wishlist'},
      {'icon': Icons.shopping_bag_rounded, 'label': 'Cart'},
      {'icon': Icons.person_rounded, 'label': 'Profile'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        boxShadow: AppShadows.cardLg,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final isSelected = selectedIndex == index;
              final item = items[index];
              final isCartTab = index == 3;
              final isWishlistTab = index == 2;

              return InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  if (onTabChange != null) {
                    onTabChange!(index);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (isDark
                            ? AppColors.surfaceVariantDark
                            : AppColors.primary.withValues(alpha: 0.08))
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            item['icon'] as IconData,
                            size: 22,
                            color: isSelected
                                ? (isDark
                                    ? Colors.white
                                    : AppColors.primary)
                                : (isDark
                                    ? AppColors.textMutedDark
                                    : AppColors.textMutedLight),
                          ),
                          // Dynamic badge on Cart Tab
                          if (isCartTab && cart.cartCount > 0)
                            Positioned(
                              right: -6,
                              top: -4,
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  color: AppColors.error,
                                  shape: BoxShape.circle,
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 14,
                                  minHeight: 14,
                                ),
                                child: Text(
                                  '${cart.cartCount}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          // Badge on Wishlist Tab
                          if (isWishlistTab && cart.wishlistCount > 0)
                            Positioned(
                              right: -5,
                              top: -3,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: AppColors.secondary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                        ],
                      ),
                      if (isSelected) ...[
                        const SizedBox(width: 6),
                        Text(
                          item['label'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? Colors.white
                                : AppColors.primary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
