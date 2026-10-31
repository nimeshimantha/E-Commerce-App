import 'package:e_commerce/models/cart.dart';
import 'package:e_commerce/models/user.dart';
import 'package:e_commerce/pages/checkout.dart';
import 'package:e_commerce/pages/dash.dart';
import 'package:e_commerce/pages/into_page.dart';
import 'package:e_commerce/pages/login.dart';
import 'package:e_commerce/pages/orders.dart';
import 'package:e_commerce/pages/signup.dart';
import 'package:e_commerce/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => UserProfile()),
      ],
      child: MaterialApp(
        title: 'Elegance Wear',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const IntroPage(),
        routes: {
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignupPage(),
          '/dash': (context) => const Dash(),
          '/checkout': (context) => const CheckoutPage(),
          '/orders': (context) => const OrdersPage(),
        },
      ),
    );
  }
}
