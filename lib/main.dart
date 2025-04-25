import 'package:flutter/material.dart';
import 'package:gocaff/pages/auth_page.dart';
import 'package:gocaff/provider/navigation_provider.dart';
import 'package:gocaff/models/shop.dart';
import 'package:provider/provider.dart';
import 'pages/intro_page.dart';
import 'pages/menu_page.dart';
import 'pages/cart_page.dart';
import 'pages/profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => Shop(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => NavigationProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const AuthPage(),
          routes: {
            '/intropage': (context) => IntroPage(
                  onTap: () {
                    Navigator.pushNamed(context, '/registerpage');
                  },
                ),
            '/menupage': (context) => const MenuPage(),
            '/cartpage': (context) => const CartPage(),
            '/profilepage': (context) => const ProfilePage(),
          },
        ),
      );
}
