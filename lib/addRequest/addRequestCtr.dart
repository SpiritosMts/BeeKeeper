import 'dart:async';
import 'package:beekeeper/addRequest/components/imagePicker/imageCtr.dart';
import 'package:beekeeper/addRequest/components/mapNoAddrPicker/mapCtr.dart';
import 'package:beekeeper/addRequest/components/radioPicker/radioCtr.dart';
import 'package:beekeeper/addRequest/components/textFields/fieldsCtr.dart';
import 'package:beekeeper/models/bkUserModel.dart';
import 'package:beekeeper/myPacks/firebase/fireBase.dart';
import 'package:beekeeper/myPacks/myConstants.dart';
import 'package:beekeeper/myPacks/myVoids.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


class AddRequestCtr extends GetxController {


  final TextFieldsCtr pFields = Get.find<TextFieldsCtr>();
  final MapPickerCtr pLocation = Get.find<MapPickerCtr>();
  final ImagePickerCtr pImages = Get.find<ImagePickerCtr>();
  final RadioPickerCtr pRadio = Get.find<RadioPickerCtr>();

  BkUser cUser = authCtr.cUser;

  @override
  void onInit() {
    super.onInit();
    print('## onInit AddStoreCtr');
  }



  goHome(){
    Get.back();
    Get.back();
  }



  Future<void> addRequest(ctx) async{


    //info

    String phone = pFields.phoneTextController.text;
    String address = pFields.addressTextController.text;
    String desc = pFields.descTextController.text;

    //location
    double lati = pLocation.lati;
    double lngi = pLocation.lngi;
    //type
    String type = pRadio.selectedType;



    if (!(pFields.formKeyCommon.currentState!.validate() || shouldNotVerifyInputs)){
      MyVoids().showTos('you must fill in the fields'.tr);
    }

    else if (!(lati*lngi != 0.0 || shouldNotVerifyInputs)){
      MyVoids().showTos('you need to pick a location'.tr);
    }

    else{
      print('## Verified store informations ✔');

      MyVoids().showLoading();

      requestsColl.add({
        //
        'name': cUser.name,
        'email': cUser.email,
        'phone': phone,
        'address': address,
        'desc': desc,
        //
        'coords': GeoPoint(lati, lngi),
        //
        'type':type,
        //
        'accepted': 'notYet',
        //
        'time':todayToString(withTime: true)
        //
        //'images': not-in-here
        //'id': not-in-here

      }).then((value)async{
        print("### Request ADDED");
        //add id
        String storeID = value.id;
        //add images & logo;
        await pImages.uploadAllImages(storeID);
        //set id
        requestsColl.doc(storeID).update({
          'id': storeID,
        });
        //hide loading dialog
        Get.back();


        await MyVoids().showSuccess(
          sucText: 'your request will be verified\nas soon as possible'.tr,
          btnOkPress: () {
            print('# btn_Ok_Pressed');
            goHome();

          },
        );
      }).catchError((error) async {
        // garage can't added
        print("## Failed to add store: $error");
        await MyVoids().showFailed(faiText:'Failed to add request'.tr);
      });
    }



    //printProps();

  }


  // printProps(){
  //   print(
  //       '_phone: ${pFields.phoneTextController.text} '
  //       '_address: ${pFields.addressTextController.text} '
  //       '_tax: ${pFields.taxTextController.text}'
  //       '_website: ${pFields.websiteTextController.text}'
  //       '_videTr: ${pFields.videoUrlTextController.text}'
  //       '_countryCode: ${pFields.selectedCountryCode}');
  //   print('### location<coords>: ${pLocation.lati} _ ${pLocation.lngi} ');
  //   print('### hours<openDays>: ${pTimes.openDays} | hours<openHours>: ${pTimes.openHours}');
  //
  // }


}
