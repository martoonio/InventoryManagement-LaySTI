import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lasti/constants.dart';
import 'package:restart_app/restart_app.dart';

class SignOutDialog extends StatelessWidget {
  const SignOutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kSecondaryColor,
        child: Container(
          height: 230,
          width: 300,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Icon(Icons.question_mark_sharp, size: 50, color: Colors.white,),
              SizedBox(
                height: 10,
              ),
              Text(
                "Logout",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Are you sure you want to logout?",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
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
                        backgroundColor: kPrimaryColor,
                        elevation: 2,
                        fixedSize: Size(100, 20)),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Restart.restartApp();
                    },
                    child: Text("Logout",
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
      );
  }
}