import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lasti/constants.dart';
import 'package:lasti/order/makeOrder.dart';
import 'package:lasti/order/orderHistory.dart';
import 'package:lasti/widget/signOutDialog.dart';

class HomeProduction extends StatefulWidget {
  const HomeProduction({Key? key}) : super(key: key);

  @override
  State<HomeProduction> createState() => _HomeProductionState();
}

class _HomeProductionState extends State<HomeProduction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffecf4d6),
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                  SignOutDialog()
              );
            },
            icon: Icon(
              Icons.logout,
              color: Colors.red,
              size: 30,
            ),
          ),
        ],
        title: Text(
          "Home Page",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => const MakeOrder()));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 50,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Make Order",
                        style: GoogleFonts.poppins(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: kSecondaryColor, elevation: 10,
                    fixedSize: Size(400, 110),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: kPrimaryColor,
                        width: 3,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => const OrderHistory()));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: Colors.white,
                        size: 50,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "History",
                        style: GoogleFonts.poppins(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: kSecondaryColor, elevation: 10,
                    fixedSize: Size(400, 110),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: kPrimaryColor,
                        width: 3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}