import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:lasti/Add%20Item/addItem.dart";
import "package:lasti/Add%20Item/viewItem.dart";
import "package:lasti/authentication/loginScreen.dart";
import "package:lasti/cart/cart_screen.dart";
import "package:lasti/constants.dart";
import "package:lasti/details/details_screen.dart";
import "package:lasti/pages/homeProduction.dart";
import "package:lasti/pages/productionPage.dart";
import "package:lasti/products/products_screen.dart";
import "package:lasti/widget/signOutDialog.dart";
import "package:restart_app/restart_app.dart";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                        MaterialPageRoute(builder: (c) => const AddItem()));
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
                        "Add Item",
                        style: GoogleFonts.poppins(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    fixedSize: Size(400, 110),
                    primary: kSecondaryColor,
                    onPrimary: Colors.white,
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
                        MaterialPageRoute(builder: (c) => const ViewItems()));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.view_list,
                        color: Colors.white,
                        size: 50,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "View Item",
                        style: GoogleFonts.poppins(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    fixedSize: Size(400, 110),
                    primary: kSecondaryColor,
                    onPrimary: Colors.white,
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => const ProductsScreen()));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.bubble_chart,
                        color: Colors.white,
                        size: 50,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Production",
                        style: GoogleFonts.poppins(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    fixedSize: Size(400, 110),
                    primary: kSecondaryColor,
                    onPrimary: Colors.white,
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
                        MaterialPageRoute(builder: (c) => CartScreen()));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.list_alt,
                        color: Colors.white,
                        size: 50,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "List Order",
                        style: GoogleFonts.poppins(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    fixedSize: Size(400, 110),
                    primary: kSecondaryColor,
                    onPrimary: Colors.white,
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
                        MaterialPageRoute(builder: (c) => HomeProduction()));
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
                    elevation: 10,
                    fixedSize: Size(400, 110),
                    primary: kSecondaryColor,
                    onPrimary: Colors.white,
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
