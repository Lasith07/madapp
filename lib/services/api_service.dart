import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/food_item.dart';

class ApiService {
  final String baseUrl = 'http://127.0.0.1:8000/api';

  Future<List<FoodItem>> fetchFoodItems() async {
    final response = await http.get(Uri.parse('$baseUrl/food-items'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => FoodItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load food items');
    }
  }
}
