import 'package:e_commerce/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;

  const AppImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.borderRadius,
    this.backgroundColor,
  });

  bool get _isNetwork =>
      imagePath.startsWith('http://') || imagePath.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fallbackBg = backgroundColor ??
        (isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight);

    Widget imageWidget;

    if (_isNetwork) {
      imageWidget = Image.network(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildPlaceholder(context, fallbackBg);
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildFallback(context, fallbackBg);
        },
      );
    } else {
      imageWidget = Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallback(context, fallbackBg);
        },
      );
    }

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: imageWidget,
      );
    }

    return imageWidget;
  }

  Widget _buildPlaceholder(BuildContext context, Color bgColor) {
    return Container(
      width: width,
      height: height,
      color: bgColor,
      child: const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
          ),
        ),
      ),
    );
  }

  Widget _buildFallback(BuildContext context, Color bgColor) {
    return Container(
      width: width,
      height: height,
      color: bgColor,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: (height != null && height! < 100) ? 24 : 36,
            color: AppColors.textMutedLight,
          ),
          const SizedBox(height: 4),
          Text(
            'Elegance',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textMutedLight,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

