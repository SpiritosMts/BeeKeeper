import 'dart:convert';

import 'package:beekeeper/myPacks/myVoids.dart';

class Requestb {
  String? id;

  //common
  String? name;
  String? email;
  String? phone;
  String? address;
  String? type;
  String? time;
  String? desc;

  double? latitude;
  double? longitude;

  //List<String>? images;
  List<dynamic>? images;

  //
  String? accepted;

  Requestb({
    this.id,
    this.name,
    this.type,
    this.phone,
    this.images,
    this.accepted,
    this.time,
    this.latitude,
    this.longitude,
    this.address,
    this.desc,
  });
}

Requestb convertDocToRequestModel(doc) {
  List<String> images = listDynamicToString(doc.get('images'));

  Requestb request = Requestb(
    id: doc.get('id'),
    name: doc.get('name'),
    desc: doc.get('desc'),
    address: doc.get('address'),
    longitude: doc.get('longitude'),
    latitude: doc.get('latitude'),
    images: images,
    accepted: doc.get('accepted'),
    phone: doc.get('phone'),
    time: doc.get('time'),
    type: doc.get('type'),
  );


  return request;
}
