import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:lasti/Add%20Item/addItem.dart";
import "package:lasti/Add%20Item/viewItem.dart";
import "package:lasti/constants.dart";
import "package:lasti/pages/productionPage.dart";

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              SizedBox(height: 10),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const ProductionPage()));
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
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.monetization_on,
                      color: Colors.white,
                      size: 50,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Supplier",
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
    );
  }
}
