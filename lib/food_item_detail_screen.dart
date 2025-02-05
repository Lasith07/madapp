import 'package:flutter/material.dart';
import 'models/food_item.dart';
import 'package:provider/provider.dart';
import 'services/cart_service.dart';

class FoodItemDetailScreen extends StatelessWidget {
  final FoodItem foodItem;
  final bool isDarkMode;

  const FoodItemDetailScreen({super.key, required this.foodItem, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isDarkMode ? Colors.grey[900] : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final subtitleColor = isDarkMode ? Colors.grey[400] : Colors.grey[700];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          foodItem.name,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: isDarkMode ? Colors.black : Colors.red,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            foodItem.imageUrl.isNotEmpty
                ? ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                foodItem.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/default_image.jpg');
                },
              ),
            )
                : Image.asset('assets/default_image.jpg'),
            const SizedBox(height: 20),
            Text(
              foodItem.name,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              foodItem.description ?? 'No description available.',
              style: TextStyle(fontSize: 18, color: subtitleColor),
            ),
            const SizedBox(height: 20),
            Text(
              'Price: \$${foodItem.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.lightGreenAccent : Colors.green,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Add food item to the cart using CartService
                  Provider.of<CartService>(context, listen: false).addItem(foodItem);

                  // Show the snack bar after adding the item to the cart
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${foodItem.name} added to cart!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: isDarkMode ? Colors.orange : Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
