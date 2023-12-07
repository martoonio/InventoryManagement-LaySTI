import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lasti/constants.dart';

class ProductionPage extends StatefulWidget {
  const ProductionPage({Key? key}) : super(key: key);

  @override
  State<ProductionPage> createState() => _ProductionPageState();
}

class _ProductionPageState extends State<ProductionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Production',
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Order List",
                      style: GoogleFonts.poppins(
                          color: kPrimaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)
                  ),
                ],
              ),
              Container(
                // margin: EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                   
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}