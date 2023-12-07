import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

String userName = "";
String userPhone = "";
String userID = FirebaseAuth.instance.currentUser!.uid;
String userFaculty = "";

String itemPhoto = "";
String itemName = "";
String itemDescription = "";
int itemQuantity = 0;

