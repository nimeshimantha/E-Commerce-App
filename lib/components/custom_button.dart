import 'package:e_commerce/theme/app_theme.dart';
import 'package:flutter/material.dart';

enum CustomButtonVariant { primary, secondary, outline }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final CustomButtonVariant variant;
  final double? width;
  final double height;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.variant = CustomButtonVariant.primary,
    this.width = double.infinity,
    this.height = 54,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color bg;
    Color fg;
    BorderSide? border;

    switch (variant) {
      case CustomButtonVariant.primary:
        bg = isDark ? Colors.white : AppColors.primary;
        fg = isDark ? AppColors.primary : Colors.white;
        border = BorderSide.none;
        break;
      case CustomButtonVariant.secondary:
        bg = AppColors.secondary;
        fg = Colors.white;
        border = BorderSide.none;
        break;
      case CustomButtonVariant.outline:
        bg = Colors.transparent;
        fg = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
        border = BorderSide(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
          width: 1.5,
        );
        break;
    }

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          disabledBackgroundColor: bg.withValues(alpha: 0.6),
          disabledForegroundColor: fg.withValues(alpha: 0.6),
          elevation: 0,
          side: border,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: isLoading
            ? SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  valueColor: AlwaysStoppedAnimation<Color>(fg),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20, color: fg),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: fg,
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
