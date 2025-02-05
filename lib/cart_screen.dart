import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/cart_service.dart';
import 'models/cart_item.dart';
import 'services/order_service.dart'; // Import OrderService

class CartScreen extends StatelessWidget {
  final bool isDarkMode;

  CartScreen({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart", style: TextStyle(color: Colors.white)),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.deepOrangeAccent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Consumer<CartService>(
        builder: (context, cartService, child) {
          if (cartService.cartItems.isEmpty) {
            return Center(
              child: Text(
                "No items in the cart",
                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              ),
            );
          }

          return ListView.builder(
            itemCount: cartService.cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = cartService.cartItems[index];
              return ListTile(
                title: Text(cartItem.foodItem.name),
                subtitle: Text(
                  "Quantity: ${cartItem.quantity}\nTotal: \$${cartItem.totalPrice}",
                  style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle, color: isDarkMode ? Colors.white : Colors.black),
                  onPressed: () {
                    cartService.removeItem(cartItem);
                  },
                ),
              );
            },
          );
        },
      ),
      bottomSheet: Consumer<CartService>(
        builder: (context, cartService, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total: \$${cartService.totalPrice}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      // Call checkout method to process order
                      await cartService.checkout(OrderService());

                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Order placed successfully!')),
                      );

                      // Optionally navigate to another screen (e.g., order confirmation screen)
                      // Navigator.pushNamed(context, '/orderConfirmation');
                    } catch (e) {
                      // Handle any errors
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $e')),
                      );
                    }
                  },
                  child: Text("Checkout"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
