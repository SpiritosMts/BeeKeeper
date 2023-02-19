import 'package:beekeeper/addRequest/components/textFields/fieldsCtr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TextFieldsView extends StatelessWidget {

  final TextFieldsCtr gc = Get.find<TextFieldsCtr>();

  @override
  Widget build(BuildContext context) {

    return   GetBuilder<TextFieldsCtr>(
        builder:(ctr)=> Column(
          children: [
            SizedBox(
              width: double.infinity,

              child: Container(
                padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child:  Text(
                  textAlign: TextAlign.start,
                  'general info'.tr,
                  style:const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Form(
                key: gc.formKeyCommon,
                child: Column(
                  children: [
                    // N°telephone_input (required)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                      child: TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          //LengthLimitingTextInputFormatter(10),// max length
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        keyboardType: TextInputType.number,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'enter phone number'.tr;
                          }
                          return null;
                        },
                        controller: gc.phoneTextController,
                        style:const TextStyle(
                          fontSize: 18,
                        ),
                        decoration:  InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          border: UnderlineInputBorder(),
                          labelText: 'phone number'.tr,
                        ),
                      ),
                    ),
                    // address_input (required)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                      child: TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(40),
                        ],
                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'enter address local'.tr;
                          }
                          return null;
                        },
                        controller: gc.addressTextController,
                        style:const TextStyle(
                          fontSize: 18,
                        ),
                        decoration:  InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          border: UnderlineInputBorder(),
                          labelText: 'address local'.tr,
                        ),
                      ),
                    ),
                    // desc_input
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                      child: TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(200),
                        ],
                        keyboardType: TextInputType.text,

                        controller: gc.descTextController,
                        style:const TextStyle(
                          fontSize: 18,
                        ),
                        decoration:  InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          border: UnderlineInputBorder(),
                          labelText: 'description'.tr,
                        ),
                      ),
                    ),

                  ],
                )
            ),
          ],
        ));

  }
}
