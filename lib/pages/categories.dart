import 'package:e_commerce/components/app_image.dart';
import 'package:e_commerce/components/product_card.dart';
import 'package:e_commerce/models/cart.dart';
import 'package:e_commerce/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatefulWidget {
  final void Function(int)? onNavigateToHomeWithCategory;

  const CategoriesPage({super.key, this.onNavigateToHomeWithCategory});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  String _selectedCategory = 'All';

  final Map<String, String> _categoryImages = {
    'Running': 'lib/images/3.png',
    'Lifestyle': 'lib/images/4.png',
    'Basketball': 'lib/images/5.png',
    'Training': 'lib/images/front.png',
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cart = Provider.of<Cart>(context);

    final displayShoes = _selectedCategory == 'All'
        ? cart.shoeShop
        : cart.shoeShop
            .where((s) =>
                s.category.toLowerCase() == _selectedCategory.toLowerCase())
            .toList();

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor:
            isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          // Category Grid Cards
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Explore Collections',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 14),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 1.35,
                    children: _categoryImages.entries.map((entry) {
                      final categoryName = entry.key;
                      final img = entry.value;
                      final count = cart.shoeShop
                          .where((s) => s.category == categoryName)
                          .length;
                      final isSelected = _selectedCategory == categoryName;

                      return InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          setState(() {
                            _selectedCategory =
                                isSelected ? 'All' : categoryName;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : (isDark
                                    ? AppColors.surfaceDark
                                    : AppColors.surfaceLight),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : (isDark
                                      ? AppColors.borderDark
                                      : AppColors.borderLight),
                              width: 1.5,
                            ),
                            boxShadow: isSelected
                                ? AppShadows.cardMd
                                : AppShadows.cardSm,
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    categoryName,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: isSelected
                                          ? Colors.white
                                          : (isDark
                                              ? AppColors.textPrimaryDark
                                              : AppColors.textPrimaryLight),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '$count items',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: isSelected
                                          ? Colors.white.withValues(alpha: 0.8)
                                          : (isDark
                                              ? AppColors.textMutedDark
                                              : AppColors.textMutedLight),
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                right: -10,
                                bottom: -10,
                                child: Transform.rotate(
                                  angle: -0.2,
                                  child: AppImage(
                                    imagePath: img,
                                    width: 75,
                                    height: 75,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),

          // Header for filtered shoes
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedCategory == 'All'
                        ? 'All Footwear (${displayShoes.length})'
                        : '$_selectedCategory (${displayShoes.length})',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                  ),
                  if (_selectedCategory != 'All')
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedCategory = 'All';
                        });
                      },
                      child: const Text('Show All'),
                    ),
                ],
              ),
            ),
          ),

          // Shoes Grid
          SliverPadding(
            padding: const EdgeInsets.all(20.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.68,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final shoe = displayShoes[index];
                  return ProductCard(
                    shoe: shoe,
                    width: double.infinity,
                  );
                },
                childCount: displayShoes.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}
