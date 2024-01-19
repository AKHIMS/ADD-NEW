// ignore_for_file: prefer_const_constructors, deprecated_member_use, avoid_print, unused_import, use_super_parameters

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Product {
  final String imageUrl;
  final String brandName;
  final String price;
  final String offer;
  final String name;

  Product({
    required this.imageUrl,
    required this.brandName,
    required this.price,
    required this.offer,
    required this.name,
  });

  factory Product.defaultProduct() {
    return Product(
      imageUrl: 'default_image_url',
      brandName: 'Default Brand',
      price: '0',
      offer: 'No Offer',
      name: 'Default Product',
    );
  }
}

class HomePage extends StatefulWidget {
  final String image;
  final List<Product> products;

  const HomePage({Key? key, required this.image, required this.products}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController brandNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController offerController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  List<Product> products = [];

  late ImagePicker _imagePicker;
  File? _image;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _imagePicker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          imageUrlController.text = ''; // Clear the image URL text field
        });
      }
    } catch (e) {
      // Handle image picking error
      print('Error picking image: $e');
    }
  }

  bool _validateInputs() {
    // Add your validation logic here
    return true;
  }

  void _saveShoe() {
    if (_validateInputs()) {
      final Map<String, dynamic> shoeDetails = _getShoeDetails();

      Product newProduct = Product(
        imageUrl: _image != null ? _image!.path : shoeDetails['imageUrl'],
        brandName: shoeDetails['brandName'],
        price: shoeDetails['price'],
        offer: shoeDetails['offer'],
        name: shoeDetails['name'],
      );

      setState(() {
        products.add(newProduct);
      });
      nameController.clear();
      brandNameController.clear();
      priceController.clear();
      offerController.clear();
      imageUrlController.clear();
      setState(() {
        _image = null;
      });
    }
  }

  Map<String, dynamic> _getShoeDetails() {
    return {
      'name': nameController.text,
      'brandName': brandNameController.text,
      'price': priceController.text,
      'offer': offerController.text,
      'imageUrl': imageUrlController.text,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Product List'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter Product Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 9),
              TextField(
                controller: brandNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter Brand Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: const InputDecoration(
                  hintText: 'Enter Price',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: offerController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: const InputDecoration(
                  hintText: 'Enter Offer',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: imageUrlController,
                decoration: const InputDecoration(
                  hintText: 'Enter Image URL',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Select Image'),
              ),
              _image != null
                  ? Image.file(
                      _image!,
                      height: 50,
                    )
                  : imageUrlController.text.isNotEmpty
                      ? Image.network(
                          imageUrlController.text,
                          height: 50,
                        )
                      : Container(),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_validateInputs()) {
                    _saveShoe();
                  }
                },
                child: const Text('Save'),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
