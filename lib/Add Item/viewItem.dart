import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lasti/constants.dart';

class ViewItems extends StatefulWidget {
  const ViewItems({super.key});

  @override
  State<ViewItems> createState() => _ViewItemsState();
}

class _ViewItemsState extends State<ViewItems> {
  TextEditingController quantityTextEditingController = TextEditingController();

  final listItem =
      FirebaseDatabase.instance.ref().child("items");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Item List',
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
        stream: listItem.onValue,
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
          List tripsList = [];
          dataTrips
              .forEach((key, value) => tripsList.add({"key": key, ...value}));

          return ListView.builder(
            shrinkWrap: true,
            itemCount: tripsList.length,
            itemBuilder: ((context, index) {
              if (tripsList[index]["name"] != null &&
                  tripsList[index]["quantity"] != null) {
                    print(tripsList[index].toString());
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Card(
                    color: kSecondaryColor,
                    // elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: kSecondaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(tripsList[index]["name"].toString(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      primary: whiteColor,
                                      elevation: 2,
                                      minimumSize: const Size(100, 50),
                                    ),
                                    onPressed: () {
                                      void saveEdit() {
                                        listItem
                                            .child(tripsList[index]["key"])
                                            .update({
                                          "quantity": quantityTextEditingController.text,
                                        }).then((value) {
                                          Navigator.pop(context);
                                        });
                                      }
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            Dialog(
                                              backgroundColor: kSecondaryColor,
                                                child: Container(
                                                  height: 220,
                                                  width: 300,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        "Edit Quantity",
                                                        style: GoogleFonts.poppins(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                                        child: TextField(
                                                          decoration: InputDecoration(
                                                            hintText: "Enter Quantity",
                                                            border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(10),
                                                              borderSide: BorderSide.none,
                                                            ),
                                                            filled: true,
                                                            fillColor: whiteColor,
                                                          ),
                                                          onChanged: (text) => setState(() {
                                                            quantityTextEditingController.text = text;
                                                          }),
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
                                                              saveEdit();
                                                            },
                                                            child: Text("Save",
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
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(tripsList[index]["quantity"].toString(),
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Icon(
                                          Icons.edit,
                                          color: kPrimaryColor,
                                          size:16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
