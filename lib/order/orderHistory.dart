import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lasti/constants.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  TextEditingController quantityTextEditingController = TextEditingController();

  final listOrder = FirebaseDatabase.instance.ref().child("requestOrder");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffecf4d6),
      appBar: AppBar(
          backgroundColor: kSecondaryColor,
          elevation: 0,
          title: Text(
            "Order List",
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
        stream: listOrder.onValue,
        builder: (BuildContext context, snapshotData) {
          if (snapshotData.hasError) {
            return Center(
              child: Text(
                "Error Occurred.",
                style: GoogleFonts.poppins(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          if (!(snapshotData.hasData)) {
            return Center(
              child: Text(
                "No item found.",
                style: GoogleFonts.poppins(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          Map dataTrips = snapshotData.data!.snapshot.value as Map;
          List itemsList = [];
          dataTrips
              .forEach((key, value) => itemsList.add({"key": key, ...value}));

          return ListView.builder(
            shrinkWrap: true,
            itemCount: itemsList.length,
            itemBuilder: ((context, index) {
              if (itemsList[index]["orderStatus"] != null &&
                  itemsList[index]["orderDateTime"] != null) {
      
                return Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Card(
                    color: kSecondaryColor,
                    elevation: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: kSecondaryColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                                        "${itemsList[index]["orderDateTime"]}",
                                                        style: GoogleFonts.poppins(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                          color: kPrimaryColor,
                                                        ),
                                                      ),
                                  ),
                                ),
                  SizedBox(height: 20,),
                  // Menambahkan informasi meja jika quantity tidak 0
                  if (itemsList[index]["meja"] != 0)
                    Text(
                      "Meja : ${itemsList[index]["meja"]}",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                  // Menambahkan informasi kursi jika quantity tidak 0
                  if (itemsList[index]["kursi"] != 0)
                    Text(
                      "Kursi : ${itemsList[index]["kursi"]}",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                  // Menambahkan informasi lemari jika quantity tidak 0
                  if (itemsList[index]["lemari"] != 0)
                    Text(
                      "Lemari : ${itemsList[index]["lemari"]}",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                  // Menambahkan informasi nakas jika quantity tidak 0
                  if (itemsList[index]["nakas"] != 0)
                    Text(
                      "Nakas : ${itemsList[index]["nakas"]}",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                  // Menambahkan informasi rak jika quantity tidak 0
                  if (itemsList[index]["rak"] != 0)
                    Text(
                      "Rak : ${itemsList[index]["rak"]}",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                  SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            side: MaterialStateProperty.resolveWith<BorderSide>(
                              (Set<MaterialState> states) {
                                return BorderSide(
                                  style: BorderStyle.solid,
                                  color: whiteColor,
                                  width: 2,
                                );
                              },
                            ),
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (itemsList[index]["orderStatus"] == 'Pending') {
                                  return kPrimaryColor;
                                } else if (itemsList[index]["orderStatus"] == 'Declined') {
                                  return Colors.red;
                                } else if (itemsList[index]["orderStatus"] == 'Accepted') {
                                  return Colors.green;
                                }
                                return Colors.grey;
                              },
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0), // Set border radius to 10
                              ),
                            ),
                          ),
                          child: Text(
                            itemsList[index]["orderStatus"].toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: () {
                                // Set text color based on 'orderStatus'
                                if (itemsList[index]["orderStatus"] == 'Pending') {
                                  return Colors.white; // Set text color for 'Pending'
                                } else if (itemsList[index]["orderStatus"] == 'Declined') {
                                  return Colors.red.shade100; // Set text color for 'Declined'
                                } else if (itemsList[index]["orderStatus"] == 'Accepted') {
                                  return Colors.green.shade100; // Set text color for 'Accepted'
                                }
                                return kPrimaryColor; // Default text color for other statuses
                              }(),
                            ),
                          ),
                        )
                      ],
                    ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Container();
              }
            }),
          );
        },
      ),
    );
  }
}