import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lasti/Add%20Item/addItem.dart';
import 'package:lasti/constants.dart';

class ViewItems extends StatefulWidget {
  const ViewItems({super.key});

  @override
  State<ViewItems> createState() => _ViewItemsState();
}

class _ViewItemsState extends State<ViewItems> {
  TextEditingController quantityTextEditingController = TextEditingController();

  final listItem = FirebaseDatabase.instance.ref().child("items");
  final historyEditQuantity = FirebaseDatabase.instance.ref().child("history");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffecf4d6),
      appBar: AppBar(
          backgroundColor: kSecondaryColor,
          elevation: 0,
          title: Text(
            "Material List",
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

          Map items = snapshotData.data!.snapshot.value as Map;
          List itemsList = [];
          items.forEach((key, value) => itemsList.add({"key": key, ...value}));

          return Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AddItem(),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.add_box_rounded,
                            color: kPrimaryColor,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Add Item",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: itemsList.length,
                    itemBuilder: ((context, index) {
                      if (itemsList[index]["name"] != null &&
                          itemsList[index]["quantity"] != null) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey,
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                  itemsList[index]["photo"]
                                                      .toString(),
                                                ),
                                              )),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                                itemsList[index]["name"]
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            Text(
                                                "Quantity : " +
                                                    itemsList[index]["quantity"]
                                                        .toString(),
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal,
                                                )),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  void saveEdit() {
                                                    listItem
                                                        .child(itemsList[index]
                                                            ["key"])
                                                        .update({
                                                      "quantity":
                                                          quantityTextEditingController
                                                              .text,
                                                    }).then((value) {
                                                      Navigator.pop(context);
                                                    });

                                                    Map historyAddedItemDataMap = {
                                                      "name": itemsList[index]["name"].toString(),
                                                      "quantity": int.parse(quantityTextEditingController.text.trim()) - int.parse(itemsList[index]["quantity"]),
                                                      "date": DateTime.now().toString(),
                                                      "status": "Added",
                                                    };
                                                    historyEditQuantity.push().set(historyAddedItemDataMap);
                                                  }

                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        Dialog(
                                                      backgroundColor:
                                                          kSecondaryColor,
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
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          20),
                                                              child: TextField(
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      "Enter Quantity",
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide:
                                                                        BorderSide
                                                                            .none,
                                                                  ),
                                                                  filled: true,
                                                                  fillColor:
                                                                      whiteColor,
                                                                ),
                                                                onChanged:
                                                                    (text) =>
                                                                        setState(
                                                                            () {
                                                                  quantityTextEditingController
                                                                          .text =
                                                                      text;
                                                                }),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                      elevation:
                                                                          2,
                                                                      fixedSize:
                                                                          Size(
                                                                              100,
                                                                              20)),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                      "Cancel",
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      )),
                                                                ),
                                                                ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                      backgroundColor:
                                                                          kPrimaryColor,
                                                                      elevation:
                                                                          2,
                                                                      fixedSize:
                                                                          Size(
                                                                              100,
                                                                              20)),
                                                                  onPressed:
                                                                      () {
                                                                    saveEdit();
                                                                  },
                                                                  child: Text(
                                                                      "Save",
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
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
                                                icon: Icon(
                                                  Icons.edit_square,
                                                  color: Colors.white,
                                                  size: 30,
                                                )),
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext
                                                                context) =>
                                                            Dialog(
                                                              backgroundColor:
                                                                  kSecondaryColor,
                                                              child: Container(
                                                                height: 240,
                                                                width: 300,
                                                                child: Column(
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Icon(
                                                                      Icons
                                                                          .delete,
                                                                      color: Colors
                                                                          .red,
                                                                      size: 50,
                                                                    ),
                                                                    Text(
                                                                      "Delete Item",
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Text(
                                                                      "Are you sure you want to delete\nthis item?",
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(
                                                                              backgroundColor: Colors.red,
                                                                              elevation: 2,
                                                                              fixedSize: Size(100, 20)),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child: Text(
                                                                              "Cancel",
                                                                              style: GoogleFonts.poppins(
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              )),
                                                                        ),
                                                                        ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(
                                                                              backgroundColor: kPrimaryColor,
                                                                              elevation: 2,
                                                                              fixedSize: Size(100, 20)),
                                                                          onPressed:
                                                                              () {
                                                                            listItem.child(itemsList[index]["key"]).remove().then((value) {
                                                                              Navigator.pop(context);
                                                                            });
                                                                          },
                                                                          child: Text(
                                                                              "Delete",
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
                                                            ));
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(width: 10),
                                                  Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                    size: 30,
                                                  ),
                                                ],
                                              ),
                                            ),
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
                    }),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
