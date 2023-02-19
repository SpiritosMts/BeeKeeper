import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RadioPickerCtr extends GetxController {


  String selectedType = '';
  changeType(type){
    selectedType = type;
    update();
  }



}
