import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:madapp/models/cart_item.dart';
import 'package:madapp/models/checkout.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to save an order to Firebase
  Future<void> checkout(Checkout order) async {
    try {
      // Save order to Firestore
      await _firestore.collection('orders').add(order.toMap());
    } catch (e) {
      throw Exception("Failed to save order: $e");
    }
  }
}
