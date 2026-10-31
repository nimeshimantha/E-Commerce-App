import 'package:e_commerce/components/app_image.dart';
import 'package:e_commerce/components/custom_button.dart';
import 'package:e_commerce/components/product_card.dart';
import 'package:e_commerce/components/section_header.dart';
import 'package:e_commerce/models/cart.dart';
import 'package:e_commerce/models/shoe.dart';
import 'package:e_commerce/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Shoe shoe;

  const ProductDetailsPage({super.key, required this.shoe});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late String _selectedSize;
  late String _selectedColor;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _selectedSize =
        widget.shoe.sizes.isNotEmpty ? widget.shoe.sizes[1] : 'US 9';
    _selectedColor =
        widget.shoe.colors.isNotEmpty ? widget.shoe.colors.first : '#111827';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cart = Provider.of<Cart>(context);
    final isFav = cart.isInWishlist(widget.shoe);

    // Related shoes
    final relatedShoes = cart.shoeShop
        .where((s) => s.id != widget.shoe.id)
        .take(3)
        .toList();

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: CustomScrollView(
        slivers: [
          // Elegant Sliver App Bar with Product Hero Image
          SliverAppBar(
            expandedHeight: 340,
            pinned: true,
            backgroundColor:
                isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: (isDark ? Colors.black : Colors.white)
                    .withValues(alpha: 0.85),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18,
                    color: isDark ? Colors.white : AppColors.textPrimaryLight,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: (isDark ? Colors.black : Colors.white)
                      .withValues(alpha: 0.85),
                  child: IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border_rounded,
                      size: 20,
                      color: isFav ? AppColors.error : AppColors.textMutedLight,
                    ),
                    onPressed: () {
                      cart.toggleWishlist(widget.shoe);
                    },
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.surfaceVariantDark
                      : AppColors.surfaceVariantLight,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Watermark Branding
                    Positioned(
                      top: 70,
                      child: Text(
                        widget.shoe.category.toUpperCase(),
                        style: TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 4,
                          color: (isDark ? Colors.white : Colors.black)
                              .withValues(alpha: 0.04),
                        ),
                      ),
                    ),
                    // Centered Hero Image
                    Hero(
                      tag: 'shoe_${widget.shoe.id}_card',
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40, bottom: 20),
                        child: AppImage(
                          imagePath: widget.shoe.imagePath,
                          height: 220,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Content Details
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
                boxShadow: AppShadows.cardLg,
              ),
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category & Rating Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.shoe.category.toUpperCase(),
                          style: const TextStyle(
                            color: AppColors.secondary,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded,
                              size: 18, color: AppColors.accent),
                          const SizedBox(width: 4),
                          Text(
                            widget.shoe.rating.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(${widget.shoe.reviewsCount} reviews)',
                            style: TextStyle(
                              fontSize: 13,
                              color: isDark
                                  ? AppColors.textMutedDark
                                  : AppColors.textMutedLight,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Product Title
                  Text(
                    widget.shoe.name,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Price & Stock
                  Row(
                    children: [
                      Text(
                        '\$${widget.shoe.price}',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight,
                        ),
                      ),
                      if (widget.shoe.originalPrice != null) ...[
                        const SizedBox(width: 10),
                        Text(
                          '\$${widget.shoe.originalPrice}',
                          style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.lineThrough,
                            color: isDark
                                ? AppColors.textMutedDark
                                : AppColors.textMutedLight,
                          ),
                        ),
                      ],
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.check_circle_outline_rounded,
                                size: 14, color: AppColors.success),
                            const SizedBox(width: 4),
                            Text(
                              'In Stock (${widget.shoe.stock})',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.success,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 12),

                  // Description
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.shoe.description,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Size Selection
                  Text(
                    'Select Size',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: widget.shoe.sizes.map((size) {
                      final isSelected = size == _selectedSize;
                      return InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          setState(() {
                            _selectedSize = size;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : (isDark
                                    ? AppColors.surfaceVariantDark
                                    : AppColors.surfaceVariantLight),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : (isDark
                                      ? AppColors.borderDark
                                      : AppColors.borderLight),
                            ),
                          ),
                          child: Text(
                            size,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : (isDark
                                      ? AppColors.textPrimaryDark
                                      : AppColors.textPrimaryLight),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // Specifications Box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.surfaceVariantDark
                          : AppColors.surfaceVariantLight,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Product Specifications',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildSpecRow(
                            context, 'Upper Material', 'Breathable Engineered Mesh'),
                        _buildSpecRow(
                            context, 'Midsole', 'Responsive EVA Foam Cushioning'),
                        _buildSpecRow(context, 'Outsole', 'High-Grip Durable Rubber'),
                        _buildSpecRow(context, 'Closure', 'Standard Lace-Up'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Related Products
                  SectionHeader(
                    title: 'You Might Also Like',
                    actionText: 'View All',
                    onActionTap: () => Navigator.pop(context),
                  ),
                  SizedBox(
                    height: 285,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: relatedShoes.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          shoe: relatedShoes[index],
                          width: 200,
                        );
                      },
                    ),
                  ),

                  // Extra bottom padding for sticky purchase bar
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),

      // Sticky Bottom Action Bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          boxShadow: AppShadows.cardLg,
          border: Border(
            top: BorderSide(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
          ),
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Quantity Stepper
              Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.surfaceVariantDark
                      : AppColors.surfaceVariantLight,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color:
                        isDark ? AppColors.borderDark : AppColors.borderLight,
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, size: 18),
                      onPressed: _quantity > 1
                          ? () => setState(() => _quantity--)
                          : null,
                    ),
                    Text(
                      '$_quantity',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, size: 18),
                      onPressed: _quantity < widget.shoe.stock
                          ? () => setState(() => _quantity++)
                          : null,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 14),

              // Add to Cart Button
              Expanded(
                child: CustomButton(
                  text: 'Add to Cart',
                  icon: Icons.shopping_bag_outlined,
                  onPressed: () {
                    cart.addCartItem(
                      widget.shoe,
                      quantity: _quantity,
                      size: _selectedSize,
                      color: _selectedColor,
                    );

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
                                'Added $_quantity x ${widget.shoe.name} ($_selectedSize) to cart',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpecRow(BuildContext context, String key, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            key,
            style: TextStyle(
              fontSize: 12,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
        ],
      ),
    );
  }
}
