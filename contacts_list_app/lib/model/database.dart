

class Shoe {
  String id;
  String name;
  String description;
  double price;
  double discount;
  double finalPrice;
  String imageUrl;

  // Constructor for creating a Shoe instance
  Shoe({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.finalPrice,
    required this.imageUrl,
  });

  // Method to convert the Shoe object to a Map
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

  // Factory method to create a Shoe object from a Map
  factory Shoe.fromMap(Map<String, dynamic> map) {
    return Shoe(
      // Extracting values from the map and providing default values if necessary
      id: map['shoe_id'].toString(), // Converting to string, assuming 'shoe_id' is a String
      name: map['name'] ?? '',        // Using empty string as a default for 'name'
      description: map['description'] ?? '', // Using empty string as a default for 'description'
      price: map['price'] ?? 0.0,      // Using 0.0 as a default for 'price'
      discount: map['discount'] ?? 0.0, // Using 0.0 as a default for 'discount'
      finalPrice: map['final_price'] ?? 0.0, // Using 0.0 as a default for 'final_price'
      imageUrl: map['imageUrl'] ?? '', // Using empty string as a default for 'imageUrl'
    );
  }
}
