import 'package:firebase_auth/firebase_auth.dart';

String userName = "";
String userPhone = "";
String userID = FirebaseAuth.instance.currentUser!.uid;
String userFaculty = "";