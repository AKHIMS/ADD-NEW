// ignore_for_file: library_private_types_in_public_api, unused_import, avoid_print, unused_element, prefer_const_constructors, non_constant_identifier_names, avoid_types_as_parameter_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_pplication/model/database.dart';
import 'package:my_pplication/model/dhHelper.dart';
import 'package:my_pplication/main.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _finalPriceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  File? _image;

  bool _validateName = false;
  bool _validateDescription = false;
  bool _validatePrice = false;
  bool _validateDiscount = false;
  bool _validateFinalPrice = false;
  bool _validateImageUrl = false;

  Map<String, dynamic> _getShoeDetails() {
    try {
      return {
        'name': _nameController.text,
        'description': _descriptionController.text,
        'price': double.parse(_priceController.text),
        'discount': double.parse(_discountController.text),
        'finalPrice': double.parse(_finalPriceController.text),
        'imageUrl': _imageUrlController.text,
        // 'imageFile': _image,
      };
    } catch (e) {
      print('Error parsing inputs: $e');
      return {};
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _discountController.dispose();
    _finalPriceController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ADD NEW',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: _buildFormWidgets(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFormWidgets() {
    return <Widget>[
      TextFormField(
        controller: _nameController,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        decoration: InputDecoration(
          labelText: 'Name',
          errorText: _validateName ? 'Name is required' : null,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.all(10.0),
        ),
      ),
      SizedBox(height: 10),
      TextFormField(
        controller: _descriptionController,
        decoration: InputDecoration(
          labelText: 'Description',
          errorText: _validateDescription ? 'Description is required' : null,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.all(10.0),
        ),
      ),
      SizedBox(height: 10),
      TextFormField(
        controller: _priceController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Price',
          errorText: _validatePrice ? 'Price is required' : null,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.all(10.0),
        ),
      ),
      SizedBox(height: 10),
      TextFormField(
        controller: _discountController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Discount',
          errorText: _validateDiscount ? 'Discount is required' : null,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.all(10.0),
        ),
      ),
      SizedBox(height: 10),
      TextFormField(
        controller: _finalPriceController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Final Price',
          errorText: _validateFinalPrice ? 'Final Price is required' : null,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.all(10.0),
        ),
      ),
      SizedBox(height: 10),
      TextFormField(
        controller: _imageUrlController,
        decoration: InputDecoration(
          labelText: 'Image URL',
          errorText: _validateImageUrl ? 'Image URL is required' : null,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.all(10.0),
        ),
      ),
      SizedBox(height: 10),
      ElevatedButton(
        onPressed: () {
          if (_validateInputs()) {
            _saveShoe();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoePage(),
                ),
                (route) => false);
            // Navigator.pop(context, _getShoeDetails());

            Fluttertoast.showToast(msg: "Saved successfully");
          }
        },
        child: Text('Save'),
      ),
    ];
  }

  bool _validateInputs() {
    setState(() {
      _validateName = _nameController.text.trim().isEmpty;
      _validateDescription = _descriptionController.text.trim().isEmpty;
      _validatePrice = _priceController.text.trim().isEmpty;
      _validateDiscount = _discountController.text.trim().isEmpty;
      _validateFinalPrice = _finalPriceController.text.trim().isEmpty;
      _validateImageUrl = _imageUrlController.text.trim().isEmpty;
    });
    return !_validateName &&
        !_validateDescription &&
        !_validatePrice &&
        !_validateDiscount &&
        !_validateFinalPrice;
    // !_validateImageUrl;
  }

  Future<void> _saveShoe() async {
    try {
      String name = _nameController.text;
      String description = _descriptionController.text;
      double price = double.parse(_priceController.text);
      double discount = double.parse(_discountController.text);
      double finalPrice = double.parse(_finalPriceController.text);
      String imageUrl = _imageUrlController.text;

      if (_image != null) {
        imageUrl = await _saveImageToStorage(_image!);
      }
      Shoe newShoe = Shoe(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        name: name,
        description: description,
        price: price,
        discount: discount,
        finalPrice: finalPrice,
        imageUrl: imageUrl,
      );
      DatabaseHelper databaseHelper = DatabaseHelper();
      await databaseHelper.insertShoe(newShoe);
      databaseHelper.close();
      print('Shoe saved successfully!');
    } catch (e) {
      print('Error saving shoe: $e');
    }
  }

  Future<String> _saveImageToStorage(File imageFile) async {
    // Add your logic to save the image to storage.
    return 'path/to/your/image';
  }
}
