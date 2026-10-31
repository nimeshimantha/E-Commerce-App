import 'package:e_commerce/components/custom_button.dart';
import 'package:e_commerce/models/cart.dart';
import 'package:e_commerce/models/order.dart';
import 'package:e_commerce/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int _selectedAddressIndex = 0;
  int _selectedPaymentIndex = 0;
  bool _isProcessing = false;

  final List<Map<String, String>> _addresses = [
    {
      'label': 'Home Address',
      'address': '742 Evergreen Terrace, Springfield, OR 97477',
      'icon': 'home',
    },
    {
      'label': 'Office / Studio',
      'address': '100 Innovation Way, Suite 400, Silicon Valley, CA 94025',
      'icon': 'work',
    },
  ];

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'name': 'Credit / Debit Card',
      'subtitle': 'Visa, Mastercard ending in 4242',
      'icon': Icons.credit_card_rounded,
    },
    {
      'name': 'Google Pay / Apple Pay',
      'subtitle': 'Fast and secure contactless payment',
      'icon': Icons.account_balance_wallet_rounded,
    },
    {
      'name': 'Cash on Delivery',
      'subtitle': 'Pay in cash upon doorstep delivery',
      'icon': Icons.local_shipping_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor:
            isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Address Section
            Text(
              'Shipping Address',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 12),
            ...List.generate(_addresses.length, (index) {
              final item = _addresses[index];
              final isSelected = _selectedAddressIndex == index;
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.secondary.withValues(alpha: 0.06)
                      : (isDark
                          ? AppColors.surfaceDark
                          : AppColors.surfaceLight),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.secondary
                        : (isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight),
                    width: isSelected ? 1.8 : 1,
                  ),
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: isSelected
                        ? AppColors.secondary
                        : (isDark
                            ? AppColors.surfaceVariantDark
                            : AppColors.surfaceVariantLight),
                    child: Icon(
                      item['icon'] == 'home'
                          ? Icons.home_rounded
                          : Icons.work_rounded,
                      color: isSelected
                          ? Colors.white
                          : AppColors.textSecondaryLight,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    item['label']!,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      item['address']!,
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                    ),
                  ),
                  trailing: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.secondary
                            : (isDark
                                ? AppColors.borderDark
                                : AppColors.borderLight),
                        width: 2,
                      ),
                    ),
                    child: isSelected
                        ? Center(
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.secondary,
                              ),
                            ),
                          )
                        : null,
                  ),
                  onTap: () {
                    setState(() {
                      _selectedAddressIndex = index;
                    });
                  },
                ),
              );
            }),

            const SizedBox(height: 20),

            // Payment Methods Section
            Text(
              'Payment Method',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 12),
            ...List.generate(_paymentMethods.length, (index) {
              final method = _paymentMethods[index];
              final isSelected = _selectedPaymentIndex == index;
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.secondary.withValues(alpha: 0.06)
                      : (isDark
                          ? AppColors.surfaceDark
                          : AppColors.surfaceLight),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.secondary
                        : (isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight),
                    width: isSelected ? 1.8 : 1,
                  ),
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: isSelected
                        ? AppColors.secondary
                        : (isDark
                            ? AppColors.surfaceVariantDark
                            : AppColors.surfaceVariantLight),
                    child: Icon(
                      method['icon'] as IconData,
                      color: isSelected
                          ? Colors.white
                          : AppColors.textSecondaryLight,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    method['name'] as String,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      method['subtitle'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                    ),
                  ),
                  trailing: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.secondary
                            : (isDark
                                ? AppColors.borderDark
                                : AppColors.borderLight),
                        width: 2,
                      ),
                    ),
                    child: isSelected
                        ? Center(
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.secondary,
                              ),
                            ),
                          )
                        : null,
                  ),
                  onTap: () {
                    setState(() {
                      _selectedPaymentIndex = index;
                    });
                  },
                ),
              );
            }),

            const SizedBox(height: 20),

            // Order Items Summary
            Text(
              'Order Summary (${cart.cartCount} items)',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                ),
              ),
              child: Column(
                children: [
                  ...cart.cartItems.map((item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${item.quantity}x ${item.shoe.name} (${item.selectedSize})',
                              style: TextStyle(
                                fontSize: 13,
                                color: isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondaryLight,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            '\$${item.totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const Divider(height: 24),
                  _buildPriceRow(
                      context, 'Subtotal', '\$${cart.subtotal.toStringAsFixed(2)}'),
                  if (cart.discountAmount > 0)
                    _buildPriceRow(
                      context,
                      'Discount',
                      '-\$${cart.discountAmount.toStringAsFixed(2)}',
                      color: AppColors.success,
                    ),
                  _buildPriceRow(
                    context,
                    'Shipping',
                    cart.shippingFee == 0
                        ? 'FREE'
                        : '\$${cart.shippingFee.toStringAsFixed(2)}',
                    color: cart.shippingFee == 0 ? AppColors.success : null,
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Due',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
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
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Confirm & Place Order Button
            CustomButton(
              text: 'Place Order Now',
              isLoading: _isProcessing,
              icon: Icons.check_circle_outline_rounded,
              onPressed: () async {
                final navigator = Navigator.of(context);
                setState(() => _isProcessing = true);
                await Future.delayed(const Duration(milliseconds: 700));

                final placedOrder = cart.placeOrder(
                  shippingAddress: _addresses[_selectedAddressIndex]['address']!,
                  paymentMethod:
                      _paymentMethods[_selectedPaymentIndex]['name'] as String,
                );

                if (!mounted) return;
                setState(() => _isProcessing = false);

                if (placedOrder != null) {
                  navigator.pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => OrderConfirmationPage(
                        order: placedOrder,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(BuildContext context, String title, String amount,
      {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color ??
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

class OrderConfirmationPage extends StatelessWidget {
  final OrderModel order;

  const OrderConfirmationPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  size: 72,
                  color: AppColors.success,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Order Placed Successfully!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Thank you for your purchase. We have received your order and are preparing it for delivery.',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),

              // Order receipt card
              Container(
                padding: const EdgeInsets.all(20),
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
                child: Column(
                  children: [
                    _buildRow(context, 'Order ID', order.id, isBold: true),
                    const Divider(height: 18),
                    _buildRow(
                        context, 'Payment', order.paymentMethod),
                    const Divider(height: 18),
                    _buildRow(
                      context,
                      'Total Paid',
                      '\$${order.total.toStringAsFixed(2)}',
                      isBold: true,
                      valueColor: AppColors.secondary,
                    ),
                    const Divider(height: 18),
                    _buildRow(context, 'Status', 'Confirmed & Processing',
                        valueColor: AppColors.success),
                  ],
                ),
              ),

              const Spacer(),

              CustomButton(
                text: 'Continue Shopping',
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/dash',
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, String key, String value,
      {bool isBold = false, Color? valueColor}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          key,
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
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: valueColor ??
                (isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight),
          ),
        ),
      ],
    );
  }
}
