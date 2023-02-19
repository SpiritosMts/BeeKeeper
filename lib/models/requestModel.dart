import 'dart:convert';

import 'package:beekeeper/myPacks/myVoids.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    this.email,
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
  GeoPoint pos = doc.get('coords');

  Requestb request = Requestb(

    id: doc.get('id'),
    name: doc.get('name'),
    desc: doc.get('desc'),
    email: doc.get('email'),
    address: doc.get('address'),
    longitude: pos.longitude,
    latitude: pos.latitude,
    images: images,
    accepted: doc.get('accepted'),
    phone: doc.get('phone'),
    time: doc.get('time'),
    type: doc.get('type'),
  );


  return request;
}
