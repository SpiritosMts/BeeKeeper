import 'dart:io';
import 'dart:math' as math;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:beekeeper/_auth/forgot_password.dart';
import 'package:beekeeper/_auth/signup.dart';
import 'package:beekeeper/_auth/verifyEmail.dart';
import 'package:beekeeper/addRequest/addRequestCtr.dart';
import 'package:beekeeper/addRequest/addRequestView.dart';
import 'package:beekeeper/main.dart';
import 'package:beekeeper/models/requestModel.dart';
import 'package:beekeeper/myPacks/myTheme/myTheme.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;


goSignUp() {
  Get.to(() => SignUp());
}
goForgotPwd() {
  Get.to(() => ForgotPassword());
}

goAddRequest() {
  Get.to(() => AddRequestView());
}

showSimpleLoading() {
  showDialog(

      barrierDismissible: false,
      context: navigatorKey.currentContext!,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: blueColHex2,
          insetPadding: EdgeInsets.symmetric(horizontal: 100.w/3,vertical: 100.h/2.6),
          //contentPadding:EdgeInsets.symmetric(horizontal: width/3) ,


          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          content: Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  SizedBox(
                    child: CircularProgressIndicator(),

                  ),

                ],
              ),
            ),
          ),
        );
      });
}
/// get date of today (yyyy-MM-dd)
String todayToString({bool withTime = false}){

  DateFormat datetimeFormat = DateFormat("HH:mm  dd-MM-yyyy");
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  //DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  if(withTime) return datetimeFormat.format(DateTime.now());
  else return dateFormat.format(DateTime.now());
}
String millisecToDateString(String dateInMilli,{bool withTime = false}){


  DateTime date = DateTime.fromMillisecondsSinceEpoch(
    int.parse(dateInMilli),
  );

  DateFormat datetimeFormat = DateFormat("HH:mm  dd-MM-yyyy");
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  //DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  if(withTime) return datetimeFormat.format(date);
  else return dateFormat.format(date);
}

/// upload one file to fb
Future<String> uploadOneImgToFb(String filePath, PickedFile? imageFile) async {
  if (imageFile != null) {
    String fileName = path.basename(imageFile.path);
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/$filePath/$fileName');

    File img = File(imageFile.path);

    final metadata = firebase_storage.SettableMetadata(contentType: 'image/jpeg', customMetadata: {
      // 'picked-file-path': 'picked000',
      // 'uploaded_by': 'A bad guy',
      // 'description': 'Some description...',
    });
    firebase_storage.UploadTask uploadTask = ref.putFile(img, metadata);

    String url = await (await uploadTask).ref.getDownloadURL();
    print('  ## uploaded image');

    return url;
  } else {
    print('  ## cant upload null image');
    return '';
  }
}

fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

fieldUnfocusAll() {
  FocusManager.instance.primaryFocus?.unfocus();
}

List<Requestb> mapToListRequestb(Map<String, Requestb> map) {
  return map.entries.map((entry) => entry.value).toList();
}

List<MarkerData> mapToListMarkerData(Map<String, MarkerData> map) {
  return map.entries.map((entry) => entry.value).toList();
}

List mapToList(Map map) {
  List list = [];
  map.forEach((k, v) => list.add(v));

  return list;
  // return   map.entries.map( (entry) => entry.value).toList();
  // return   map.entries.map( (entry) => {entry.key , entry.value}).toList(); // you can use key or value of each element of that map
}

listDynamicToString(List<dynamic> list) {
  return list.map((e) => e as String).toList();
}

mapToString(mapToConvert) {
  return mapToConvert.map((key, value) => MapEntry(key, value.toString()));
}

TimeOfDay stringToTimeOfDay(stringTime) {
  String formattedTodayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime openTime = DateTime.parse('$formattedTodayDate $stringTime:00');
  return TimeOfDay.fromDateTime(openTime);
}

class MyVoids {

  showVerifyConnexion(){
    AwesomeDialog(
      dialogBackgroundColor: blueColHex2,

      autoDismiss: true,
      dismissOnTouchOutside: true,
      animType: AnimType.SCALE,
      headerAnimationLoop: false,
      dialogType: DialogType.INFO,
      btnOkColor: Colors.blueAccent,
      // btnOkColor: yellowColHex

      //showCloseIcon: true,
      padding: EdgeInsets.symmetric(vertical: 15.0),

      title: 'Failed to Connect'.tr,
      desc: 'please verify network'.tr,

      btnOkOnPress: () {

      },
      onDismissCallback: (type) {
        print('Dialog Dissmiss from callback $type');
      },
      //btnOkIcon: Icons.check_circle,
      context: navigatorKey.currentContext!,

    ).show();
  }

   showLoading() {
    return AwesomeDialog(
      dialogBackgroundColor: blueColHex2,

      dismissOnBackKeyPress: true,
      //change later to false
      autoDismiss: true,
      customHeader: Transform.scale(
        scale: .7,
        child: const LoadingIndicator(
          indicatorType: Indicator.ballClipRotate,
          colors: [yellowColHex],
          strokeWidth: 10,
        ),
      ),

      context: navigatorKey.currentContext!,
      dismissOnTouchOutside: false,
      animType: AnimType.SCALE,
      headerAnimationLoop: false,
      dialogType: DialogType.NO_HEADER,

      title: 'Loading'.tr,
      desc: 'Please wait'.tr,
    ).show();
  }

   showFailed({String? faiText}) {
    return AwesomeDialog(
        dialogBackgroundColor: blueColHex2,

        autoDismiss: true,
        context: navigatorKey.currentContext!,
        dismissOnTouchOutside: false,
        animType: AnimType.SCALE,
        headerAnimationLoop: false,
        dialogType: DialogType.ERROR,
        //showCloseIcon: true,
        title: 'Failure'.tr,
        btnOkText: 'Ok'.tr,
        descTextStyle: GoogleFonts.almarai(
          height: 1.8,
          textStyle: const TextStyle(fontSize: 14),
        ),
        desc: faiText,
        btnOkOnPress: () {},
        btnOkColor: Colors.red,
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        }).show();
    ;
  }

   showSuccess({String? sucText, Function()? btnOkPress}) {
    return AwesomeDialog(
      dialogBackgroundColor: blueColHex2,

      autoDismiss: true,
      context: navigatorKey.currentContext!,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: false,
      dismissOnTouchOutside: false,
      animType: AnimType.leftSlide,
      dialogType: DialogType.success,
      //showCloseIcon: true,
      //title: 'Success'.tr,

      descTextStyle: GoogleFonts.almarai(
        height: 1.8,
        textStyle: const TextStyle(fontSize: 14),
      ),
      desc: sucText,
      btnOkText: 'Ok'.tr,

      btnOkOnPress: () {
        btnOkPress!();
      },
      // onDissmissCallback: (type) {
      //   debugPrint('## Dialog Dissmiss from callback $type');
      // },
      //btnOkIcon: Icons.check_circle,
    ).show();
  }

   showShouldVerify() {
    return AwesomeDialog(
      dialogBackgroundColor: blueColHex2,

      autoDismiss: true,
        context: navigatorKey.currentContext!,

      showCloseIcon: true,
      dismissOnTouchOutside: true,
      animType: AnimType.SCALE,
      headerAnimationLoop: false,
      dialogType: DialogType.INFO,
      title: 'Verification'.tr,
      desc: 'Your email is not verified\nVerify now?'.tr,
      btnOkText: 'Verify'.tr,
      btnOkColor: Colors.blue,
      btnOkIcon: Icons.send,
      btnOkOnPress: () {
        Get.to(() => VerifyScreen());
      },
      padding: EdgeInsets.symmetric(vertical: 20.0),
    ).show();
  }

  Future<bool> showNoHeader({String? txt,String? btnOkText='delete',Color btnOkColor=Colors.red,IconData? icon=Icons.delete}) async {
    bool shouldDelete = false;

    await AwesomeDialog(
      context: navigatorKey.currentContext!,
      dialogBackgroundColor: blueColHex2,
      autoDismiss: true,
      isDense: true,
      dismissOnTouchOutside: true,
      showCloseIcon: false,
      headerAnimationLoop: false,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      btnCancelIcon: Icons.close,
      btnCancelColor: Colors.grey,
      btnOkIcon: icon ?? Icons.delete,
      btnOkColor: btnOkColor,
      buttonsTextStyle: TextStyle(fontSize: 17.sp),
      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
      // texts
      title: 'Verification'.tr,
      desc: txt ?? 'Are you sure you want to delete this image'.tr,
      btnCancelText: 'cancel'.tr,
      btnOkText: btnOkText!.tr ,

      // buttons functions
      btnOkOnPress: () {
        shouldDelete = true;
      },
      btnCancelOnPress: () {
        shouldDelete = false;
      },




    ).show();
    return shouldDelete;
  }



  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = math.cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * math.asin(math.sqrt(a));
  }

  showTos(txt, {Color color = Colors.black87}) async {
    Fluttertoast.showToast(
        msg: txt,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  Future<bool> canConnectToInternet() async {
    bool canConnect = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      /// connected to internet
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //is connected
        canConnect = true;
      }
      /// failed to connect to internet
    } on SocketException catch (_) {
      // not connected

    }
    return canConnect;
  }

}



/// browse_image

Future<PickedFile> selectImage(ImageSource source) async {
  final pickedFile = await ImagePicker().getImage(
    source: source,
  );
  Get.back();
  return pickedFile!;
}

Future<PickedFile>  showImageChoiceDialog()async  {
  PickedFile? image ;

  await  showDialog(
      context: navigatorKey.currentContext!,
      builder: (_) {
        return AlertDialog(
          backgroundColor: blueColHex2,
          title:  Text(
            "Choose source".tr,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                const Divider(
                  height: 1,
                ),
                ListTile(
                  onTap: () async{
                    image = await selectImage(ImageSource.gallery);
                  },
                  title: Text("Gallery".tr),
                  leading: const Icon(
                    Icons.image,
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                ListTile(
                  onTap: () async {
                    image = await selectImage(ImageSource.camera);
                  },
                  title: Text("Camera".tr),
                  leading: const Icon(
                    Icons.camera,
                  ),
                ),
              ],
            ),
          ),
        );
      });


  return image!;

}
/// get.Dialog without context
// void reduceItemDialog(ctx) {
//   Future.delayed(const Duration(seconds: 1), () {
//     Get.dialog(
//         barrierDismissible: false,
//         ReduceItemView());
//   });
//   showDialog(
//     barrierDismissible: false,
//     context: ctx,
//     builder: (_) => AlertDialog(
//       backgroundColor: blueColHex2,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(
//           Radius.circular(12.0),
//         ),
//       ),
//       content: ReduceItemView(),
//     ),
//   );
//
//   //update();
// }
