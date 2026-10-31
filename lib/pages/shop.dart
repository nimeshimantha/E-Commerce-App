import 'package:e_commerce/components/category_chip.dart';
import 'package:e_commerce/components/empty_state.dart';
import 'package:e_commerce/components/product_card.dart';
import 'package:e_commerce/components/promo_banner.dart';
import 'package:e_commerce/components/section_header.dart';
import 'package:e_commerce/models/cart.dart';
import 'package:e_commerce/models/user.dart';
import 'package:e_commerce/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  final void Function(int)? onNavigateTab;

  const ShopPage({super.key, this.onNavigateTab});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final user = Provider.of<UserProfile>(context);
    final cart = Provider.of<Cart>(context);
    final shoes = cart.filteredShoes;

    final userName = user.name ?? 'Guest';

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.secondary,
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 500));
            setState(() {});
          },
          child: CustomScrollView(
            slivers: [
              // Modern Personalized Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary,
                              border: Border.all(
                                color: isDark
                                    ? AppColors.borderDark
                                    : AppColors.borderLight,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                userName.isNotEmpty
                                    ? userName[0].toUpperCase()
                                    : 'E',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome back,',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: isDark
                                      ? AppColors.textMutedDark
                                      : AppColors.textMutedLight,
                                ),
                              ),
                              Text(
                                userName,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.3,
                                  color: isDark
                                      ? AppColors.textPrimaryDark
                                      : AppColors.textPrimaryLight,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Actions: Notification & Cart with Badge
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.surfaceDark
                                  : AppColors.surfaceLight,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isDark
                                    ? AppColors.borderDark
                                    : AppColors.borderLight,
                              ),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.notifications_none_rounded),
                              iconSize: 22,
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('No new notifications right now.'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? AppColors.surfaceDark
                                      : AppColors.surfaceLight,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isDark
                                        ? AppColors.borderDark
                                        : AppColors.borderLight,
                                  ),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                      Icons.shopping_bag_outlined),
                                  iconSize: 22,
                                  onPressed: () {
                                    if (widget.onNavigateTab != null) {
                                      widget.onNavigateTab!(3); // Cart tab
                                    }
                                  },
                                ),
                              ),
                              if (cart.cartCount > 0)
                                Positioned(
                                  right: 0,
                                  top: -2,
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                      color: AppColors.error,
                                      shape: BoxShape.circle,
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 18,
                                      minHeight: 18,
                                    ),
                                    child: Text(
                                      '${cart.cartCount}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Search Bar
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.surfaceDark
                          : AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight,
                      ),
                      boxShadow: AppShadows.cardSm,
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) {
                        cart.setSearchQuery(val);
                      },
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search shoes, styles or categories...',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: isDark
                              ? AppColors.textMutedDark
                              : AppColors.textMutedLight,
                        ),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          size: 22,
                          color: AppColors.secondary,
                        ),
                        suffixIcon: cart.searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close_rounded, size: 18),
                                onPressed: () {
                                  _searchController.clear();
                                  cart.setSearchQuery('');
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 18)),

              // Promotional Banner Carousel (shown when not searching)
              if (cart.searchQuery.isEmpty) ...[
                const SliverToBoxAdapter(
                  child: PromoBannerCarousel(),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],

              // Category Selector Chips
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 44,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: cart.categories.length,
                    itemBuilder: (context, index) {
                      final cat = cart.categories[index];
                      final isSelected = cart.selectedCategory == cat;
                      return CategoryChip(
                        label: cat,
                        isSelected: isSelected,
                        onTap: () {
                          cart.setCategory(cat);
                        },
                      );
                    },
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              // Featured Hot Deals Section
              if (cart.searchQuery.isEmpty && shoes.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: SectionHeader(
                    title: 'Featured Drops',
                    actionText: 'See All',
                    onActionTap: () {
                      if (widget.onNavigateTab != null) {
                        widget.onNavigateTab!(1); // Categories tab
                      }
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 285,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 20, right: 4),
                      itemCount: shoes.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          shoe: shoes[index],
                          width: 210,
                        );
                      },
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
              ],

              // All / Filtered Products Section Header
              SliverToBoxAdapter(
                child: SectionHeader(
                  title: cart.searchQuery.isNotEmpty
                      ? 'Search Results (${shoes.length})'
                      : (cart.selectedCategory == 'All'
                          ? 'New Arrivals'
                          : '${cart.selectedCategory} Collection'),
                ),
              ),

              // Product Grid or Empty Search State
              if (shoes.isEmpty)
                SliverToBoxAdapter(
                  child: EmptyState(
                    icon: Icons.search_off_rounded,
                    title: 'No Shoes Found',
                    message:
                        'We couldn\'t find any pair matching "${cart.searchQuery}". Try searching for another style or brand.',
                    buttonText: 'Reset Filters',
                    onButtonPressed: () {
                      _searchController.clear();
                      cart.setSearchQuery('');
                      cart.setCategory('All');
                    },
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.68,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ProductCard(
                          shoe: shoes[index],
                          width: double.infinity,
                        );
                      },
                      childCount: shoes.length,
                    ),
                  ),
                ),

              // Extra bottom spacing
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],
          ),
        ),
      ),
    );
  }
}
