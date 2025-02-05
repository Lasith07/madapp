import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';  // Ensure this file is generated using the FlutterFire CLI
import 'services/cart_service.dart';
import 'services/network_service.dart';  // Import the NetworkService
import 'login_screen.dart';
import 'food_item_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(  // Use MultiProvider to include both CartService and NetworkService
      providers: [
        ChangeNotifierProvider(create: (context) => CartService()),
        ChangeNotifierProvider(create: (context) => NetworkService()),  // Add NetworkService here
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Divine Bliss',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: LoginScreen(),  // Set the initial screen to LoginScreen
      routes: {
        '/foodItem': (context) => FoodItemScreen(isDarkMode: false), // Define other routes
        // Add other routes if necessary
      },
    );
  }
}
