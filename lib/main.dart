import 'package:e_commerce/models/cart.dart';
import 'package:e_commerce/models/user.dart';
import 'package:e_commerce/pages/into_page.dart';
import 'package:e_commerce/pages/login.dart';
import 'package:e_commerce/pages/signup.dart';
import 'package:e_commerce/pages/dash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
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
        debugShowCheckedModeBanner: false,
        home: const IntroPage(),
        routes: {
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignupPage(),
          '/dash': (context) => const Dash(),
        },
      ),
    );
  }
}
