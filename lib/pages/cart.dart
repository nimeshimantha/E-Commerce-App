import 'package:e_commerce/components/app_image.dart';
import 'package:e_commerce/components/custom_button.dart';
import 'package:e_commerce/components/empty_state.dart';
import 'package:e_commerce/models/cart.dart';
import 'package:e_commerce/pages/checkout.dart';
import 'package:e_commerce/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  final VoidCallback? onBrowseProducts;

  const CartPage({super.key, this.onBrowseProducts});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final TextEditingController _promoController = TextEditingController();

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text('My Cart (${cart.cartCount})'),
        backgroundColor:
            isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        elevation: 0,
        actions: [
          if (cart.cartItems.isNotEmpty)
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Clear Cart'),
                    content: const Text(
                        'Are you sure you want to remove all items from your cart?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          cart.clearCart();
                          Navigator.pop(ctx);
                        },
                        style: TextButton.styleFrom(
                            foregroundColor: AppColors.error),
                        child: const Text('Clear All'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text(
                'Clear',
                style: TextStyle(color: AppColors.error),
              ),
            ),
        ],
      ),
      body: cart.cartItems.isEmpty
          ? EmptyState(
              icon: Icons.shopping_bag_outlined,
              title: 'Your Cart is Empty',
              message:
                  'Looks like you haven\'t added any footwear yet. Find your perfect pair and step up your game!',
              buttonText: 'Discover Footwear',
              onButtonPressed: widget.onBrowseProducts,
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: cart.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cart.cartItems[index];
                      return Dismissible(
                        key: ValueKey(
                            '${item.shoe.id}_${item.selectedSize}_${item.selectedColor}'),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: AppColors.error,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        onDismissed: (direction) {
                          cart.removeCartItem(item);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                  '${item.shoe.name} removed from your cart'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  cart.addCartItem(
                                    item.shoe,
                                    quantity: item.quantity,
                                    size: item.selectedSize,
                                    color: item.selectedColor,
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.surfaceDark
                                : AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isDark
                                  ? AppColors.borderDark
                                  : AppColors.borderLight,
                            ),
                            boxShadow: AppShadows.cardSm,
                          ),
                          child: Row(
                            children: [
                              // Shoe Thumbnail
                              Container(
                                width: 85,
                                height: 85,
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? AppColors.surfaceVariantDark
                                      : AppColors.surfaceVariantLight,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.all(6),
                                child: AppImage(
                                  imagePath: item.shoe.imagePath,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(width: 14),

                              // Info Column
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.shoe.name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: isDark
                                            ? AppColors.textPrimaryDark
                                            : AppColors.textPrimaryLight,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: isDark
                                                ? AppColors.surfaceVariantDark
                                                : AppColors.surfaceVariantLight,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            item.selectedSize,
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: isDark
                                                  ? AppColors.textSecondaryDark
                                                  : AppColors
                                                      .textSecondaryLight,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '\$${item.shoe.price}',
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

                              // Stepper Controls
                              Container(
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? AppColors.surfaceVariantDark
                                      : AppColors.surfaceVariantLight,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isDark
                                        ? AppColors.borderDark
                                        : AppColors.borderLight,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove, size: 16),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(
                                        minWidth: 32,
                                        minHeight: 32,
                                      ),
                                      onPressed: () {
                                        cart.updateItemQuantity(item, -1);
                                      },
                                    ),
                                    Text(
                                      '${item.quantity}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add, size: 16),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(
                                        minWidth: 32,
                                        minHeight: 32,
                                      ),
                                      onPressed: () {
                                        cart.updateItemQuantity(item, 1);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Order Calculation & Checkout Bottom Sheet
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color:
                        isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                    boxShadow: AppShadows.cardLg,
                    border: Border(
                      top: BorderSide(
                        color: isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight,
                      ),
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Promo code box
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 46,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? AppColors.surfaceVariantDark
                                      : AppColors.surfaceVariantLight,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isDark
                                        ? AppColors.borderDark
                                        : AppColors.borderLight,
                                  ),
                                ),
                                child: TextField(
                                  controller: _promoController,
                                  style: const TextStyle(fontSize: 13),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    contentPadding:
                                        const EdgeInsets.symmetric(vertical: 12),
                                    hintText: cart.appliedPromo ??
                                        'Promo code (Try: ELEGANCE10)',
                                    hintStyle: TextStyle(
                                      fontSize: 12,
                                      color: cart.appliedPromo != null
                                          ? AppColors.success
                                          : AppColors.textMutedLight,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              height: 46,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (cart.appliedPromo != null) {
                                    cart.removePromo();
                                    _promoController.clear();
                                  } else {
                                    final success = cart
                                        .applyPromo(_promoController.text);
                                    if (success) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Promo code applied!'),
                                          backgroundColor: AppColors.success,
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Invalid promo code'),
                                          backgroundColor: AppColors.error,
                                        ),
                                      );
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: cart.appliedPromo != null
                                      ? AppColors.error
                                      : AppColors.primary,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                ),
                                child: Text(cart.appliedPromo != null
                                    ? 'Remove'
                                    : 'Apply'),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Subtotal
                        _buildSummaryRow(
                          context,
                          'Subtotal',
                          '\$${cart.subtotal.toStringAsFixed(2)}',
                        ),
                        if (cart.discountAmount > 0)
                          _buildSummaryRow(
                            context,
                            'Promo Discount',
                            '-\$${cart.discountAmount.toStringAsFixed(2)}',
                            valueColor: AppColors.success,
                          ),
                        _buildSummaryRow(
                          context,
                          'Shipping',
                          cart.shippingFee == 0
                              ? 'FREE'
                              : '\$${cart.shippingFee.toStringAsFixed(2)}',
                          valueColor: cart.shippingFee == 0
                              ? AppColors.success
                              : null,
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Divider(),
                        ),

                        // Total Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Amount',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$${cart.totalAmount.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: isDark
                                    ? AppColors.textPrimaryDark
                                    : AppColors.textPrimaryLight,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Checkout Button
                        CustomButton(
                          text: 'Proceed to Checkout',
                          icon: Icons.lock_outline_rounded,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CheckoutPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String label,
    String value, {
    Color? valueColor,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: valueColor ??
                  (isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight),
            ),
          ),
        ],
      ),
    );
  }
}
