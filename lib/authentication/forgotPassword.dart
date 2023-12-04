import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lasti/authentication/loginScreen.dart';
import 'package:lasti/constants.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  final emailTextEditingController = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void _submit() {
    firebaseAuth
        .sendPasswordResetEmail(email: emailTextEditingController.text)
        .then((value) {
      Fluttertoast.showToast(
          msg:
              "We have sent you an email to recover password, please check your email");
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: "Error Occured : \n ${error.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        // FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: kPrimaryColor,
            title: Text(
              'RideWave',
              style: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
          ),
          body: ListView(padding: EdgeInsets.all(0), children: [
            Column(
              children: [
                Text("Forgot Password",
                    style: TextStyle(color: Colors.white, fontSize: 12)),
                SizedBox(height: 30),
                Image.asset(
                  'images/cover.png',
                  width: 400,
                  height: 200,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFormField(
                                style: GoogleFonts.poppins(
                                  color: kPrimaryColor,
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(50)
                                ],
                                decoration: InputDecoration(
                                  hintText: "Enter Your Email",
                                  hintStyle: GoogleFonts.poppins(
                                    color: Colors.white,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFF82A5B3),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                        color: Color(0xFF82A5B3)),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.mail,
                                    color: Colors.white,
                                  ),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (EmailValidator.validate(text) == false) {
                                    return 'Please enter a valid email';
                                  }
                                  if (text.length < 3) {
                                    return 'Please enter a valid email';
                                  }
                                  if (text.length > 99) {
                                    return 'Email must be less than 100 characters long';
                                  }
                                  if (!text.endsWith("ac.id")) {
                                    return 'Please use our ac.id email';
                                  }
                                  return null;
                                },
                                onChanged: (text) => setState(() {
                                  emailTextEditingController.text = text;
                                }),
                              ),
                              SizedBox(height: 60),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF054C67),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(color: Colors.white),
                                  ),
                                  minimumSize: Size(200, 50),
                                ),
                                onPressed: () {
                                  _submit();
                                },
                                child: Text(
                                  "Reset Password",
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account? ",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginScreen()));
                                      },
                                      child: Text(
                                        "Sign In!",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          )),
                    ],
                  ),
                )
              ],
            ),
          ])),
    );
  }
}
