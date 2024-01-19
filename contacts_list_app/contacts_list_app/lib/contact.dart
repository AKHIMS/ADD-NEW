// models/shoe_model.dart
class Shoe {
  int id;
  String imageUrl;
  String brand;
  String name;
  double price;
  String status;

  Shoe({
    required this.id,
    required this.imageUrl,
    required this.brand,
    required this.name,
    required this.price,
    required this.status,
  });
}
