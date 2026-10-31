import 'package:e_commerce/components/app_image.dart';
import 'package:e_commerce/components/custom_button.dart';
import 'package:e_commerce/models/user.dart';
import 'package:e_commerce/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20),
          child: Column(
            children: [
              // Header Brand Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.electric_bolt_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'ELEGANCE WEAR',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2.0,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Hero Visual Presentation
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.secondary.withValues(alpha: 0.18),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: -0.22,
                    child: const Hero(
                      tag: 'intro_hero_shoe',
                      child: AppImage(
                        imagePath: 'lib/images/front.png',
                        width: 280,
                        height: 240,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Main Titles & Tagline
              Text(
                'Let Your Foot Feel\nThe Ultimate Comfort',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.8,
                  height: 1.2,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'Discover premium athletic and lifestyle footwear engineered for performance, durability, and elegance.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),

              const SizedBox(height: 36),

              // Action Buttons
              CustomButton(
                text: 'Get Started',
                icon: Icons.arrow_forward_rounded,
                onPressed: () => Navigator.pushNamed(context, '/login'),
              ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: () {
                  // Guest mode: set default guest user if needed and enter
                  if (!context.read<UserProfile>().isSignedIn) {
                    context
                        .read<UserProfile>()
                        .setUser(name: 'Guest Shopper', email: 'guest@elegance.com');
                  }
                  Navigator.pushReplacementNamed(context, '/dash');
                },
                child: Text(
                  'Continue as Guest',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
