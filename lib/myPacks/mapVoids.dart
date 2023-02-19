import 'package:beekeeper/main.dart';
import 'package:beekeeper/myPacks/myConstants.dart';
import 'package:beekeeper/myPacks/myVoids.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


void moveCamPosTo(gMapctr,double zoom,double lat, double lng) async {
  final CameraPosition newCameraPosition = CameraPosition(
    target: LatLng(lat, lng),
    zoom: zoom,
  );
  final  ctr = await gMapctr.future;

  ctr.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
}





Future<LatLng> getCurrentLocation(gMapCtr,{LatLng posOnLocErr =const LatLng(0.0, 0.0),bool moveCamToUser = false}) async {
  //default position
  LatLng currUserPos =posOnLocErr;
  /// without initial LatLng
 await Geolocator.getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.best).then((pos)  {
    // affect curr user pos
     currUserPos =LatLng(pos.latitude, pos.longitude);
    print('### curr_pos >${currUserPos.latitude}/${currUserPos.longitude} <');
     sharedPrefs!.setDouble('savedUserLat', currUserPos.latitude);
     sharedPrefs!.setDouble('savedUserLng', currUserPos.longitude);
     //animate cam
   if(moveCamToUser) moveCamPosTo(gMapCtr,animateZoom,currUserPos.latitude, currUserPos.longitude);
  }).catchError((err) {
    print("## Failed to get user current location : $err");
    MyVoids().showTos('can\'t found you location'.tr);
  });
  return currUserPos;
}

Future<void> openGoogleMapApp(double latitude, double longitude) async {
  String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  if (await canLaunch(googleUrl)) {
    await launch(googleUrl);
  } else {
    throw 'Could not open the map.';
  }
}
/// map_style
class MapStyleCtr extends GetxController {

  @override
  void onInit() {
    super.onInit();
    //print('## init MapStyleCtr');
    getMapStyleStatus();
    _loadMapStyles();
  }
  String? darkMapStyle;
  String? lightMapStyle;

  Future _loadMapStyles() async {
      darkMapStyle  = await rootBundle.loadString('assets/map_styles/dark.json');
      lightMapStyle  = await rootBundle.loadString('assets/map_styles/light.json');

  }

  void seMapStyle( gMapctr) async {

    final ctr = await gMapctr.future;
    if(isDarkMap){
      ctr.setMapStyle(darkMapStyle);
    }else{
      ctr.setMapStyle(lightMapStyle);

    }


  }


  bool isDarkMap = false;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  saveMapStyleStatus() async {
    SharedPreferences pref = await _prefs;
    pref.setBool('mapStyle', isDarkMap);
  }

  getMapStyleStatus() async {
    var isActive = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('mapStyle') ?? true;
    }).obs;
    isDarkMap = await isActive.value;
  }


  onSwitch(val,gMapctr) {
    isDarkMap = val;
    seMapStyle(gMapctr);
    print('## map dark Style active <$isDarkMap>');
    saveMapStyleStatus();
    update();
  }
}