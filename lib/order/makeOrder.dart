import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lasti/constants.dart';
import 'package:lasti/global/global_var.dart';

class MakeOrder extends StatefulWidget {
  const MakeOrder({Key? key}) : super(key: key);

  @override
  State<MakeOrder> createState() => _MakeOrderState();
}

class _MakeOrderState extends State<MakeOrder> {
  DatabaseReference orderRef =
      FirebaseDatabase.instance.ref().child("requestOrder");

  DatabaseReference historyRef =
      FirebaseDatabase.instance.ref().child("history");

  DatabaseReference listItem = FirebaseDatabase.instance.ref().child("items");

  Map orderMap = {};

  //debug material map

  requestOrder() {
    bool isAccepted = false;
    orderMap = {
      "orderDateTime": DateTime.now().toString(),
      "meja": mejaQuantity,
      "kursi": kursiQuantity,
      "lemari": lemariQuantity,
      "nakas": nakasQuantity,
      "rak": rakQuantity,
      "orderStatus": "Pending",
      "orderDeadline": DateTime.now().add(Duration(days: 3)).toString(),
    };

    checkMaterialStock();
    //     Meja
    // kayu 3, sekrup 8, lem 2, cat 1
    // Kusi
    // kayu 2, sekrup 8, lem 2, cat 1
    // Lemari
    // kayu 8, sekrup 24, paku 24, 1 kaca, 1 cat
    // Nakas
    // 2 kayu, 8 sekrup, 4 paku, 1 lem, 1 cat
    // Rak
    // 10 besi, 24 sekrup, 2 kayu, 1 cat

    if (mejaQuantity > 0) {
      if (kayu >= 3 && sekrup >= 8 && lemariQuantity >= 2 && cat >= 1) {
        isAccepted = true;
      }else{
        isAccepted = false;
      }
    }
    if (kursiQuantity > 0) {
      if (kayu >= 2 && sekrup >= 8 && lemariQuantity >= 2 && cat >= 1) {
        isAccepted = true;
      }else{
        isAccepted = false;
      }
    }
    if (lemariQuantity > 0) {
      if (kayu >= 8 &&
          sekrup >= 24 &&
          paku >= 24 &&
          kaca >= 1 &&
          cat >= 1) {
        isAccepted = true;
      }else{
        isAccepted = false;
      }
    }
    if (nakasQuantity > 0) {
      if (kayu >= 2 && sekrup >= 8 && paku >= 4 && lemariQuantity >= 1) {
        isAccepted = true;
      }else{
        isAccepted = false;
      }
    }
    if (rakQuantity > 0) {
      if (besi >= 10 && sekrup >= 24 && kayu >= 2 && cat >= 1) {
        isAccepted = true;
      }else{
        isAccepted = false;
      }
    }

    materialMap.forEach((key, value) {});
    if(isAccepted){
      orderRef.push().set(orderMap);
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
    }else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: kSecondaryColor,
            title: Text("Failed",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: whiteColor,
                )),
            content: Text("Item not added, please check your material stock",
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
    }
  }

  int mejaQuantity = 0;
  int kursiQuantity = 0;
  int lemariQuantity = 0;
  int nakasQuantity = 0;
  int rakQuantity = 0;
  int kayu = 0;
  int paku = 0;
  int cat = 0;
  int sekrup = 0;
  int besi = 0;
  int kaca = 0;

  checkMaterialStock() {
    materialMap.forEach((key, value) {
      if (value["name"] == "kayu") {
        kayu = int.parse(value["quantity"]);
      }
      if (value["name"] == "paku") {
        paku = int.parse(value["quantity"]);
      }
      if (value["name"] == "cat") {
        cat = int.parse(value["quantity"]);
      }
      if (value["name"] == "sekrup") {
        sekrup = int.parse(value["quantity"]);
      }
      if (value["name"] == "besi") {
        besi = int.parse(value["quantity"]);
      }
      if (value["name"] == "kaca") {
        kaca = int.parse(value["quantity"]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffecf4d6),
      appBar: AppBar(
          backgroundColor: kSecondaryColor,
          elevation: 0,
          title: Text(
            "Make Order",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Product List",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Image(
                      image: Image.asset("images/meja.png").image,
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Meja",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 130,
                      height: 50,
                      margin: EdgeInsets.only(left: 30),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: mejaQuantity > 0
                                ? () {
                                    setState(() {
                                      mejaQuantity--;
                                    });
                                  }
                                : null,
                            icon: Icon(
                              Icons.remove,
                              color: kPrimaryColor,
                              size: 15,
                            ),
                          ),
                          Text(
                            mejaQuantity.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                mejaQuantity++;
                              });
                            },
                            icon: Icon(
                              Icons.add,
                              color: kPrimaryColor,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Image(
                      image: Image.asset("images/kursi.png").image,
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Kursi",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 130,
                      height: 50,
                      margin: EdgeInsets.only(left: 30),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: kursiQuantity > 0
                                ? () {
                                    setState(() {
                                      kursiQuantity--;
                                    });
                                  }
                                : null,
                            icon: Icon(
                              Icons.remove,
                              color: kPrimaryColor,
                              size: 15,
                            ),
                          ),
                          Text(
                            kursiQuantity.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                kursiQuantity++;
                              });
                            },
                            icon: Icon(
                              Icons.add,
                              color: kPrimaryColor,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Image(
                      image: Image.asset("images/lemari.png").image,
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Lemari",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 130,
                      height: 50,
                      margin: EdgeInsets.only(left: 30),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: lemariQuantity > 0
                                ? () {
                                    setState(() {
                                      lemariQuantity--;
                                    });
                                  }
                                : null,
                            icon: Icon(
                              Icons.remove,
                              color: kPrimaryColor,
                              size: 15,
                            ),
                          ),
                          Text(
                            lemariQuantity.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                lemariQuantity++;
                              });
                            },
                            icon: Icon(
                              Icons.add,
                              color: kPrimaryColor,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Image(
                      image: Image.asset("images/nakas.png").image,
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Nakas",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 130,
                      height: 50,
                      margin: EdgeInsets.only(left: 30),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: nakasQuantity > 0
                                ? () {
                                    setState(() {
                                      nakasQuantity--;
                                    });
                                  }
                                : null,
                            icon: Icon(
                              Icons.remove,
                              color: kPrimaryColor,
                              size: 15,
                            ),
                          ),
                          Text(
                            nakasQuantity.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                nakasQuantity++;
                              });
                            },
                            icon: Icon(
                              Icons.add,
                              color: kPrimaryColor,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Image(
                      image: Image.asset("images/rak.png").image,
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Rak",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 130,
                      height: 50,
                      margin: EdgeInsets.only(left: 30),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: rakQuantity > 0
                                ? () {
                                    setState(() {
                                      rakQuantity--;
                                    });
                                  }
                                : null,
                            icon: Icon(
                              Icons.remove,
                              color: kPrimaryColor,
                              size: 15,
                            ),
                          ),
                          Text(
                            rakQuantity.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                rakQuantity++;
                              });
                            },
                            icon: Icon(
                              Icons.add,
                              color: kPrimaryColor,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          shape: BoxShape.rectangle,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 20,
            ),
            Text(
              "Total :",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: whiteColor,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              (mejaQuantity +
                      kursiQuantity +
                      lemariQuantity +
                      nakasQuantity +
                      rakQuantity)
                  .toString(),
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: whiteColor,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Item",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: whiteColor,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => Dialog(
                    backgroundColor: kSecondaryColor,
                    child: Container(
                      height: 300,
                      width: 300,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Order Details",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Meja : " + mejaQuantity.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Kursi : " + kursiQuantity.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Lemari : " + lemariQuantity.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Nakas : " + nakasQuantity.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Rak : " + rakQuantity.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    elevation: 2,
                                    fixedSize: Size(100, 20)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: kPrimaryColor,
                                    elevation: 2,
                                    fixedSize: Size(100, 20)),
                                onPressed: () {
                                  Navigator.pop(context);
                                  requestOrder();
                                },
                                child: Text("Order",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: Text(
                "Order",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 10,
                fixedSize: Size(120, 50),
                primary: kSecondaryColor,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  side: BorderSide(
                    color: kPrimaryColor,
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
