import 'package:cloud_firestore/cloud_firestore.dart';
import 'cart_item.dart';


class Checkout {
  final List<CartItem> items;
  final double totalPrice;
  final DateTime date;
  final String status;

  Checkout({
    required this.items,
    required this.totalPrice,
    required this.date,
    this.status = 'Pending',
  });

  // Convert Checkout to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'items': items.map((cartItem) => cartItem.toMap()).toList(),
      'totalPrice': totalPrice,
      'date': Timestamp.fromDate(date),
      'status': status,
    };
  }
}
