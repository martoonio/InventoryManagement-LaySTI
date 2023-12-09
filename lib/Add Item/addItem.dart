import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
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
  DatabaseReference historyRef =
      FirebaseDatabase.instance.ref().child("history");

  Map itemDataMap = {}; // Pindahkan inisialisasi ke sini

  Map historyAddedItemDataMap = {}; // Pindahkan inisialisasi ke sini

  addItem() async {
    // Perbarui itemDataMap di dalam metode addItem
    itemDataMap = {
      "photo": urlOfUploadedImage,
      "name": itemNameTextEditingController.text.trim(),
      "quantity": quantityTextEditingController.text.trim(),
      "dateAdded": DateTime.now().toString(),
      "description": descriptionTextEditingController.text.trim(),
    };

    // Perbarui historyAddedItemDataMap di dalam metode addItem
    historyAddedItemDataMap = {
      "photo": urlOfUploadedImage,
      "name": itemNameTextEditingController.text.trim(),
      "quantity": quantityTextEditingController.text.trim(),
      "date": DateTime.now().toString(),
      "description": descriptionTextEditingController.text.trim(),
      "status": "Added",
    };

    if (itemNameTextEditingController.text.isNotEmpty &&
        quantityTextEditingController.text.isNotEmpty &&
        descriptionTextEditingController.text.isNotEmpty) {
      itemsRef.push().set(itemDataMap);
      historyRef.push().set(historyAddedItemDataMap);
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
                )),
            content: Text("Item added successfully",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: whiteColor,
                )),
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
                    )),
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

  XFile? imageFile;
  String urlOfUploadedImage = "";

  uploadImageToStorage() async {
    String imageIDName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceImage =
        FirebaseStorage.instance.ref().child("Images").child(imageIDName);

    UploadTask uploadTask = referenceImage.putFile(File(imageFile!.path));
    TaskSnapshot snapshot = await uploadTask;
    urlOfUploadedImage = await snapshot.ref.getDownloadURL();

    setState(() {
      urlOfUploadedImage;
    });

    addItem();
  }

  chooseImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile;
      });
    }
    print('${imageFile!.path}}');
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xfff7faec),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: StreamBuilder(
          stream: itemsRef.onValue,
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Icon(
                                Icons.chevron_left,
                                color: kSecondaryColor,
                                size: 40,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Back",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: kSecondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      imageFile != null
                          ? Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                shape: BoxShape
                                    .rectangle, // Mengubah bentuk menjadi rectangle
                                color: Colors.transparent,
                                image: DecorationImage(
                                  fit: BoxFit
                                      .cover, // Memastikan gambar mencakup seluruh container
                                  image: FileImage(File(imageFile!.path)),
                                ),
                              ),
                            )
                          : Center(
                              child: IconButton(
                                onPressed: () {
                                  chooseImageFromGallery();
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
                          uploadImageToStorage();
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
                          foregroundColor: Colors.white, backgroundColor: kSecondaryColor, elevation: 10,
                          fixedSize: Size(150, 50),
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
          }),
    );
  }
}
