// ignore_for_file: library_private_types_in_public_api, file_names, sized_box_for_whitespace, avoid_print, use_super_parameters, prefer_typing_uninitialized_variables, unused_field, unnecessary_string_interpolations, unused_import, prefer_const_constructors, unnecessary_null_comparison, unused_local_variable

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_pplication/model/database.dart';
import 'package:my_pplication/screen/details_page.dart';
import 'package:my_pplication/model/dhHelper.dart';
import 'package:my_pplication/screen/inputpage.dart';

class ShoePage extends StatefulWidget {
  const ShoePage({Key? key}) : super(key: key);

  @override
  _ShoePageState createState() => _ShoePageState();
}

class _ShoePageState extends State<ShoePage> {
  final List<String> _sortOptions = [
    'Newest',
    'Relevance',
    'Popularity',
    'Low Price',
    'High Price'
  ];
  String _selectedValue = 'Newest';

  List<Shoe> shoesList = [];

  @override
  void initState() {
    super.initState();
    fetchShoes();
  }

  Future<void> fetchShoes() async {
    try {
      // Using the DatabaseHelper singleton to fetch shoes
      DatabaseHelper databaseHelper = DatabaseHelper();
      List<Shoe> fetchedShoes = await databaseHelper.getShoes();
      setState(() {
        shoesList = fetchedShoes;
      });
    } catch (e) {
      print('Error fetching shoes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            "COMMON PROJECTS",
            style: TextStyle(color: Colors.black, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Colors.white,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: IconButton(
                icon: Icon(Icons.menu_rounded, color: Colors.black, size: 25),
                onPressed: () {},
              ),
            ),
            Flexible(
              flex: 1,
              child: IconButton(
                icon: Icon(Icons.search, color: Colors.black, size: 25),
                onPressed: () {},
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              // Navigating to the InputPage
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InputPage()),
              );
            },
            icon: Icon(
              Icons.add_outlined,
              color: Colors.black,
            ),
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          Divider(height: 1, thickness: 1),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  width: size.width / 2,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      "Refine products",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: size.width / 2,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        child: Text(
                          'Sorted by',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Container(
                        height: 60,
                        width: 98,
                        child: DropdownButton<String>(
                          onChanged: (value) {
                            // Updating the selected value and triggering a rebuild
                            setState(() {
                              _selectedValue = value!;
                            });
                            print(value);
                          },
                          value: _selectedValue,
                          items:
                              _sortOptions.map<DropdownMenuItem<String>>((e) {
                            return DropdownMenuItem<String>(
                              value: e,
                              child: Text(
                                e,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }).toList(),
                          elevation: 0,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          isExpanded: true,
                          style: TextStyle(fontSize: 15),
                          itemHeight: 50,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(height: 1, thickness: 1),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: shoesList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.3,
              ),
              itemBuilder: (context, index) {
                Shoe currentShoe = shoesList[index];

                return InkWell(
                  onTap: () {
                    // Navigating to ShoePage2 with the selected shoe
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShoePage2(shoe: currentShoe),
                      ),
                    );
                  },
                  child: ShoeCard(
                    key: ValueKey<String>(currentShoe.id.toString()),
                    currentShoe: currentShoe,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ShoeCard extends StatelessWidget {
  final Shoe currentShoe;

  const ShoeCard({
    Key? key,
    required this.currentShoe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Card(
                elevation: 0,
                child: Container(
                  height: 120,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 247, 245, 245),
                  ),
                  child: _buildShoeImage(),
                ),
              ),
              SizedBox(height: 10),
              Text(
                currentShoe.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 5),
              Text(
                currentShoe.description,
                style: TextStyle(fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 5),
              Text('Price: ${currentShoe.price}',
                  style: TextStyle(fontSize: 12)),
              SizedBox(height: 5),
              Text('Discount: ${currentShoe.discount}',
                  style: TextStyle(fontSize: 12)),
              SizedBox(height: 5),
              Text('Final Price: ${currentShoe.finalPrice}',
                  style: TextStyle(fontSize: 12)),
            ],
          ),
        )
      ],
    );
  }

  // Widget to build the shoe image based on the imageUrl
  Widget _buildShoeImage() {
    if (currentShoe.imageUrl != null && currentShoe.imageUrl.isNotEmpty) {
      if (currentShoe.imageUrl.startsWith('http') ||
          currentShoe.imageUrl.startsWith('https')) {
        // If the imageUrl is a valid HTTP/HTTPS link, load the image from the network
        return Image.network(
          currentShoe.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // Handling errors while loading the image
            print('Error loading image: $error');
            return Container(
              color: Colors.grey,
              child: Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
            );
          },
        );
      } else if (currentShoe.imageUrl.startsWith('google:')) {
        // If the imageUrl starts with 'google:', use a default Google logo
        String googleImageUrl = currentShoe.imageUrl.replaceFirst('google:','');
        return Image.network(
          'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // Handling errors while loading the Google image
            print('Error loading Google image: $error');
            return Container(
              color: Colors.grey,
              child: Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
            );
          },
        );
      } else {
        // Handling invalid image URLs
        print('Invalid image URL: ${currentShoe.imageUrl}');
      }
    }

    // Placeholder for cases where the imageUrl is null or empty
    return Placeholder(
      color: Colors.grey,
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ShoePage(),
    debugShowCheckedModeBanner: false,
  ));
}
