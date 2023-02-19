
import 'package:beekeeper/home/customMarker.dart';
import 'package:beekeeper/home/selectedRequest/selectedStView.dart';
import 'package:beekeeper/models/bkUserModel.dart';
import 'package:beekeeper/models/requestModel.dart';
import 'package:beekeeper/myPacks/firebase/fireBase.dart';
import 'package:beekeeper/myPacks/mapVoids.dart';
import 'package:beekeeper/myPacks/myConstants.dart';
import 'package:beekeeper/myPacks/myVoids.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';



class HomeCtr extends GetxController {
  final MapStyleCtr mapCtr = Get.find<MapStyleCtr>();

  bool printDet =false;
  Completer<GoogleMapController> gMapCtr = Completer();

  Requestb selectedRq = Requestb();



  Map<String, Requestb> requestMap = {}; // all downloaded requests

  Map<String, MarkerData> rqMarkers = {}; // contain all markers of all requests depends on storePos(latLng)


  late LatLng userPos = const LatLng(0.0, 0.0);


  BkUser cUser = BkUser();

  @override
  onInit() {
    super.onInit();
    cUser = authCtr.cUser;

    Future.delayed(const Duration(milliseconds: 50), ()  {
      downloadRequestsFromDb().whenComplete(()async {
      });

    });
    getUserLocation();

  }

  @override
  void onClose() {
    super.onClose();
    print('## close HomeCtr');
  }



  onMapCreated(controller) async {
     //gMapCtr = Completer();
     if (!gMapCtr.isCompleted) {
       //updateMap();
       gMapCtr.complete(controller);
       mapCtr.seMapStyle(gMapCtr);
       updateMap();
     } else {
       //other calling, later is true,
       //don't call again completer()
     }
   }
  selectRqToModify(request) {
     selectedRq = request;
   }

   /// get ueer-location
  getUserLocation() async {
   await Geolocator.requestPermission();
    userPos = await getCurrentLocation(gMapCtr,moveCamToUser: true);

  }





  updateMap() {
    update(['map']);
    print('## reload map_builder');
  }




  /// ///////////// get requests from fb /////////////////////////////////////
 Future<void> downloadRequestsFromDb() async {
   print('## downloading requests from fb...');
    List<DocumentSnapshot> storesData =  await getDocumentsByCollCondition(requestsColl);


    requestMap.clear();// Remove any existing requests
    for (var doc in storesData) {// fill storeMap with requests models
     requestMap[doc.id] = convertDocToRequestModel(doc);
   }


     print('## all requests number: < ${requestMap.length} >');



   await loadMarkers(requestMap);
   updateMap();


 } // download requests data from db and put them as models( <Requestb> model)
  loadMarkers(Map<String, Requestb> requests) {

    // Remove any existing markers
    rqMarkers.clear();

    for(Requestb st in requests.values){
      rqMarkers[st.id!] = MarkerData(
          marker: Marker(
            markerId: MarkerId(st.id!),
            position: LatLng(st.latitude!, st.longitude!),
            onTap: () {
              if(cUser.isAdmin==true){
                selectedRq = requestMap[st.id!]!;
                Get.to(() => SelectedRqView());
              }
            },
          ),
          child: customMarkerImg(st)
      );
    }
    updateMap();
  }  // fill stMarkers with requests positions(lat-lng)
  /// //////////////////////////////////////////////////:


/// /////////////////////////



}
