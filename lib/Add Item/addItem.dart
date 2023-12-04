import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lasti/constants.dart';
import 'package:flutter/material.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController itemNameTextEditingController = TextEditingController();
  TextEditingController quantityTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();

  DatabaseReference itemsRef = FirebaseDatabase.instance.ref().child("items");

  Map itemDataMap = {}; // Pindahkan inisialisasi ke sini

  addItem() async {
    // Perbarui itemDataMap di dalam metode addItem
    itemDataMap = {
      "name": itemNameTextEditingController.text.trim(),
      "quantity": quantityTextEditingController.text.trim(),
      "description": descriptionTextEditingController.text.trim(),
    };

    if (itemNameTextEditingController.text.isNotEmpty &&
        quantityTextEditingController.text.isNotEmpty &&
        descriptionTextEditingController.text.isNotEmpty){
      itemsRef.push().set(itemDataMap);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: kSecondaryColor,
            title: Text("Success",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: whiteColor,
                )
              ),
            content: Text("Item added successfully",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: whiteColor,
                )
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text("Ok",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: whiteColor,
                    )
                  ),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Please fill all the fields"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Ok"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffecf4d6),
      appBar: AppBar(
          backgroundColor: kSecondaryColor,
          elevation: 0,
          title: Text(
            "Add Item",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.chevron_left,
              color: kPrimaryColor,
              size: 40,
            ),
          )),
      body: StreamBuilder(
        stream: itemsRef.onValue,
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Center(
                      child: IconButton(
                        onPressed: () {
                          // Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.camera_alt,
                          color: kSecondaryColor,
                          size: 100,
                        ),
                      ),
                    ),
                    Text(
                      "Insert Image",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: kSecondaryColor,
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      style: GoogleFonts.poppins(
                        color: kPrimaryColor,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(50),
                      ],
                      decoration: InputDecoration(
                        hintText: "Item Name",
                        hintStyle: GoogleFonts.poppins(
                          color: kSecondaryColor,
                        ),
                        filled: true,
                        fillColor: whiteColor,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: kSecondaryColor,
                            width: 3,
                          ),
                        ),
                        hoverColor: kPrimaryColor,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                            width: 3,
                          ),
                        ),
                      ),
                      onChanged: (text) => setState(() {
                        itemNameTextEditingController.text = text;
                      }),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: quantityTextEditingController,
                      style: GoogleFonts.poppins(
                        color: kPrimaryColor,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(50),
                      ],
                      decoration: InputDecoration(
                        hintText: "Quantity",
                        hintStyle: GoogleFonts.poppins(
                          color: kSecondaryColor,
                        ),
                        filled: true,
                        fillColor: whiteColor,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: kSecondaryColor,
                            width: 3,
                          ),
                        ),
                        hoverColor: kPrimaryColor,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                            width: 3,
                          ),
                        ),
                      ),
                      onChanged: (text) => setState(() {
                        quantityTextEditingController.text = text;
                      }),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: descriptionTextEditingController,
                      style: GoogleFonts.poppins(
                        color: kPrimaryColor,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(50),
                      ],
                      decoration: InputDecoration(
                        hintText: "Description",
                        hintStyle: GoogleFonts.poppins(
                          color: kSecondaryColor,
                        ),
                        filled: true,
                        fillColor: whiteColor,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: kSecondaryColor,
                            width: 3,
                          ),
                        ),
                        hoverColor: kPrimaryColor,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                            width: 3,
                          ),
                        ),
                      ),
                      onChanged: (text) => setState(() {
                        descriptionTextEditingController.text = text;
                      }),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        addItem();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add Item",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        fixedSize: Size(150, 50),
                        primary: kSecondaryColor,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
