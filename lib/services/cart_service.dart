import 'package:flutter/material.dart';
import 'package:madapp/models/food_item.dart';
import 'package:madapp/models/cart_item.dart';
import 'package:madapp/services/order_service.dart';
import 'package:madapp/models/checkout.dart';

class CartService with ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addItem(FoodItem foodItem) {
    final index = _cartItems.indexWhere((cartItem) => cartItem.foodItem.id == foodItem.id);

    if (index != -1) {
      _cartItems[index].quantity++;
    } else {
      _cartItems.add(CartItem(foodItem: foodItem, quantity: 1));
    }

    notifyListeners();
  }

  void removeItem(CartItem cartItem) {
    _cartItems.remove(cartItem);
    notifyListeners();
  }

  double get totalPrice =>
      _cartItems.fold(0.0, (sum, cartItem) => sum + cartItem.totalPrice);

  // Checkout method
  Future<void> checkout(OrderService orderService) async {
    if (_cartItems.isEmpty) {
      throw Exception("Cart is empty");
    }

    // Create a checkout object with cart items and total price
    final order = Checkout(
      items: _cartItems, // Pass the list of CartItem objects directly
      totalPrice: totalPrice,
      date: DateTime.now(),
      status: 'Pending', // You can define order status as needed
    );

    // Call the order service to save the order in Firebase
    await orderService.checkout(order);

    // Clear the cart after successful checkout
    _cartItems.clear();
    notifyListeners();
  }
} // <-- This closing brace was missing
