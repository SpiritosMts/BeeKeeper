import 'package:beekeeper/home/homeView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'firebase/fireBaseAuth.dart';
const CameraPosition susahPos = CameraPosition(target: LatLng( 51.260197, 4.402771), zoom: 10.0);
var commaFormatter = NumberFormat('#,###,###');

int nameMaxLength = 30;
int categNameMaxLength = 50;
int itemNameMaxLength = 50;


double animateZoom = 16.0;
double horiCardHeight = 215;

double subtitleSize = 22.sp;
double noFoundSize = 18.sp;

var requestsColl = FirebaseFirestore.instance.collection('requests');
var usersColl = FirebaseFirestore.instance.collection('bk_users');
var notifsColl = FirebaseFirestore.instance.collection('notifications');
String usersCollName = 'bk_users';
bool shouldNotVerifyInputs = false;
bool shouldVerifyAccount = true;
bool showMarkerLogo = true;
double storeLogoSize =25.0;
double btmPaddingInput =5.0;
double btmPaddingInputPrc =0.0;
String? get currLang => Get.locale!.languageCode;

  goToHomePage(){
    Get.offAll(()=> Home());
 }




AuthController authCtr = AuthController.instance;
int refreshVerifInSec =5;
//final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
FirebaseAuth auth = FirebaseAuth.instance;
User? get authCurrUser => FirebaseAuth.instance.currentUser;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
GoogleSignIn googleSign = GoogleSignIn();


