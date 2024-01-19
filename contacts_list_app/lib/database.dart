class Shoe {
  String id;
  String name;
  String description;
  double price;
  double discount;
  double finalPrice;
  String imageUrl;

  Shoe({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.finalPrice,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'shoe_id': id,
      'name': name,
      'description': description,
      'price': price,
      'discount': discount,
      'imageUrl': imageUrl,
      'final_price': finalPrice,
    };
  }

  factory Shoe.fromMap(Map<String, dynamic> map) {
    return Shoe(
      id: map['shoe_id'].toString(), // Corrected to 'shoe_id'
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? 0.0,
      discount: map['discount'] ?? 0.0,
      finalPrice: map['final_price'] ?? 0.0,
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}
