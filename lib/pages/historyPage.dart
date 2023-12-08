import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lasti/constants.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final listHistory = FirebaseDatabase.instance.ref().child("history");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffecf4d6),
        appBar: AppBar(
            backgroundColor: kSecondaryColor,
            elevation: 0,
            title: Text(
              "History",
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
            stream: listHistory.onValue,
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
              List history = [];
              items.forEach(
                  (key, value) => history.add({"key": key, ...value}));

              return Container(
                child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Materials In",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        if (history[index]["status"] == "Added") {
                          return Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 20),
                            child: Card(
                              color: kSecondaryColor,
                              elevation: 10,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('${history[index]["name"]}'),
                                        Text('${history[index]["quantity"]}'),
                                      ],
                                    ),
                                    subtitle: Text('${history[index]["date"]}'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Materials Out",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        if (history[index]["status"] == "Removed") {
                          return Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 20),
                            child: Card(
                              color: kSecondaryColor,
                              elevation: 10,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('${history[index]["name"]}'),
                                        Text('${history[index]["quantity"]}'),
                                      ],
                                    ),
                                    subtitle: Text('${history[index]["date"]}'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),
              );
        }
      )
    );
  }
}
