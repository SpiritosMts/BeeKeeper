import 'dart:async';
import 'package:beekeeper/myPacks/cards.dart';
import 'package:beekeeper/myPacks/firebase/fireBase.dart';
import 'package:beekeeper/myPacks/myConstants.dart';
import 'package:beekeeper/myPacks/myTheme/myTheme.dart';
import 'package:beekeeper/myPacks/myVoids.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:flutter/widgets.dart' as wig;
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';


class ImagePickerCtr extends GetxController {
  PickedFile? imageFile;
  List<PickedFile>? imageFileList = [];
  String rqID = '';


  @override
  void onInit() {


  }

  clearImageFile() {
    imageFile = null;
    update();
  }
  updateCtr() {
    update();
  }

  //update multi-images
  updateImages(image){
    if(image != null){
      imageFileList!.add(image!);
      print('## <${imageFileList!.length}> image choosen');
      update();
    }
  }

  // new added images
  singleImage(List imageFileList, index) {
    return Padding(
      padding: EdgeInsets.all(0.0),
      child: Stack(
        children: [
          Card(
            color: blueColHex2,

            child: imageFileList.isNotEmpty
                ? Center(
                    child: wig.Image.file(
                      File(imageFileList[index].path),
                      fit: BoxFit.cover,
                      width: 150,
                    ),
                  )
                : Container(),
          ),
          Positioned(
            top: -4,
            right: -4,
            child: IconButton(
              icon: const Icon(Ionicons.close_circle),
              color: Colors.grey,
              splashRadius: 1,
              onPressed: () {
                imageFileList.removeAt(index);
                update();
              },
            ),
          ),
        ],
      ),
    );
  }

  /// upload logo if added & images to fb
  Future<void> uploadAllImages(uniqueID) async {

    ///images

    List<String>? urls = [];
    if (imageFileList!.isNotEmpty) {
      print('### found new images to add');
      for (int i = 0; i < imageFileList!.length; i++) {
        var url = await uploadOneImgToFb('requests/$uniqueID/images', imageFileList![i]);
        urls.add(url);
      }
    }

     requestsColl.doc(uniqueID).update(
       {
         'images': urls,
       },
       //SetOptions(merge: true),
     );
  }



}

