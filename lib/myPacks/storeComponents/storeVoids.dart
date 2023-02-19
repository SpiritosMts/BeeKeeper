import 'package:beekeeper/models/requestModel.dart';
import 'package:beekeeper/myPacks/firebase/fireBase.dart';
import 'package:beekeeper/myPacks/myConstants.dart';
import 'package:beekeeper/myPacks/myVoids.dart';

import 'package:get/get.dart';


/// DECLINE & APPROVE requests
declineRequest(id) {
  MyVoids().showNoHeader( txt: 'are you sure you want to decline this Request?'.tr,btnOkText: 'decline').then((value) {
    if (value) {
      /// decline Request from coll
      requestsColl.doc(id).update({
        'accepted':'no'
      }).then((value) async {
        MyVoids().showTos('Request declined'.tr);
        Get.back();
      }).catchError((error) => print("Failed to decline Request: $error"));
    }
  });
}
approveRequest(id) {
 
  /// approve Request from coll
  requestsColl.doc(id).update({
    'accepted':'yes'
  }).then((value) async {
    MyVoids().showTos('Request approved'.tr);

    Get.back();

  }).catchError((error) => print("Failed to approve Request: $error"));
}
///







