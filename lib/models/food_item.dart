class FoodItem {
  final int id;
  final String name;
  final String? description;
  final String imageUrl;
  final double price; // Add this line for the price

  FoodItem({
    required this.id,
    required this.name,
    this.description,
    required this.imageUrl,
    required this.price, // Add this to the constructor
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['image_url'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,  // Safely parse price
    );
  }

}
