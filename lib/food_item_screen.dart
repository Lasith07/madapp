import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/food_item.dart';
import 'services/api_service.dart';
import 'food_item_detail_screen.dart';
import 'services/cart_service.dart';
import 'cart_screen.dart'; // New cart screen

class FoodItemScreen extends StatelessWidget {
  final ApiService apiService = ApiService();
  final bool isDarkMode;

  FoodItemScreen({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text("Menu", style: TextStyle(color: Colors.white)),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.red,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(isDarkMode: isDarkMode),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<FoodItem>>(
        future: apiService.fetchFoodItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: \${snapshot.error}",
                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No menu items available",
                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              ),
            );
          } else {
            final foodItems = snapshot.data!;
            return ListView.builder(
              itemCount: foodItems.length,
              itemBuilder: (context, index) {
                final foodItem = foodItems[index];
                String description = foodItem.description ?? 'Delicious and freshly prepared';

                return Card(
                  color: isDarkMode ? Colors.grey[850] : Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    title: Text(
                      foodItem.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
                      ),
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: foodItem.imageUrl.isNotEmpty
                          ? Image.network(
                        foodItem.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      )
                          : Image.asset(
                        'assets/default_image.jpg',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    onTap: () {
                      // Pass isDarkMode to FoodItemDetailScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FoodItemDetailScreen(
                            foodItem: foodItem,
                            isDarkMode: isDarkMode,  // Pass isDarkMode here
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
