// ignore_for_file: library_private_types_in_public_api, sized_box_for_whitespace, avoid_print, use_super_parameters, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_pplication/database.dart';

class ShoePage2 extends StatefulWidget {
  const ShoePage2({Key? key, required this.shoe}) : super(key: key);

  final Shoe shoe;

  @override
  _ShoePage2State createState() => _ShoePage2State();
}

class _ShoePage2State extends State<ShoePage2> {
  late String _imageUrl; // Image URL
  final _color = ['Yellow', 'Black', 'Green', 'Blue', 'Red', 'Gray'];
  final _size = ['38', '39', '40', '41', '42', '43'];
  int myCurrentIndex = 0;

  String _selectedColor = 'Yellow';
  String _selectedSize = '38';

  @override
  Widget build(BuildContext context) {
    _imageUrl = widget.shoe.imageUrl; // Set the image URL from the Shoe object

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.shoe.name,
            style: TextStyle(color: Colors.black, fontSize: 18),
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
            onPressed: () {
              // Navigate back to the previous screen
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.checkroom_outlined,
              color: Colors.black,
            ),
          ),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: false,
                      height: 200,
                      onPageChanged: (index, reason) {
                        setState(() {
                          myCurrentIndex = index;
                        });
                      },
                    ),
                    items: [
                      Image.network(_imageUrl, fit: BoxFit.cover),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.shoe.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  widget.shoe.description,
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 5),
                Text(
                  '\$${widget.shoe.finalPrice}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 20),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50,
                      width: 170,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            child: Text(
                              "COLOR:",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 2),
                          Container(
                            height: 50,
                            width: 70,
                            child: DropdownButton<String>(
                              onChanged: (value) {
                                setState(() {
                                  _selectedColor = value!;
                                });
                                print(value);
                              },
                              value: _selectedColor,
                              items: _color.map<DropdownMenuItem<String>>((e) {
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
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              underline: Container(
                                height: 0,
                              ),
                              isExpanded: true,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                              itemHeight: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 50,
                      width: 170,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            child: Text(
                              "SIZE:",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 2),
                          Container(
                            height: 50,
                            width: 50,
                            child: DropdownButton<String>(
                              onChanged: (value) {
                                setState(() {
                                  _selectedSize = value!;
                                });
                                print(value);
                              },
                              value: _selectedSize,
                              items: _size.map<DropdownMenuItem<String>>((e) {
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
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              underline: Container(
                                height: 0,
                              ),
                              isExpanded: true,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                              itemHeight: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            Container(
              height: 50,
              width: 420,
              color: Colors.black,
              child: Center(
                child: Transform.translate(
                  offset: Offset(0, 0),
                  child: Text(
                    "ADD TO CART   \$${widget.shoe.finalPrice}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Column(
              children: [
                Text(
                  "DESCRIPTION",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 10),
                Text(
                  widget.shoe.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 13, height: 1.8, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(height: 5, thickness: 2),
            SizedBox(height: 20),
            Column(
              children: [
                Text("SIZE & FIT", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Divider(height: 5, thickness: 2),
                SizedBox(height: 20),
                Text("DETAILS & CARE", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
