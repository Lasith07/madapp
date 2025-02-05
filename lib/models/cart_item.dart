import 'food_item.dart';

class CartItem {
  final FoodItem foodItem;
  int quantity;

  CartItem({required this.foodItem, this.quantity = 1});

  double get totalPrice => foodItem.price * quantity;

  // Convert CartItem to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'foodItemId': foodItem.id,   // Assuming FoodItem has an 'id' field
      'foodItemName': foodItem.name, // Assuming FoodItem has a 'name' field
      'quantity': quantity,
      'totalPrice': totalPrice,
    };
  }
}
