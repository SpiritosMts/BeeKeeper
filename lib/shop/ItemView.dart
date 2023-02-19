import 'package:auto_size_text/auto_size_text.dart';
import 'package:beekeeper/models/itemModel.dart';
import 'package:beekeeper/myPacks/cards.dart';
import 'package:beekeeper/myPacks/myTheme/myTheme.dart';
import 'package:beekeeper/shop/shopCtr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ItemView extends StatefulWidget {
  const ItemView({Key? key}) : super(key: key);

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  Item item = Get.find<ShopCtr>().selectedItem;

  ///item_info
  itemInfo(Item item) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //item_img
          SizedBox(
            width: 100.w,
            height: 250,
            child:shimmerImage(item.imageUrl)
          ),
          //item_name/price
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 70.w,
                  //color:Colors.redAccent,

                  child: Padding(
                      padding: const EdgeInsets.only(right: 17),
                      child: AutoSizeText(
                        item.name!,
                        style: TextStyle(fontSize: 30, height: 1.3),
                        minFontSize: 18,
                        maxFontSize: 30,
                        maxLines: 3,
                      )),
                ),
                Container(
                  width: 30.w,
                  //color: Colors.green,

                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // normal_price
                        AutoSizeText(
                          "${item.price} dt",
                          style: GoogleFonts.almarai(
                              textStyle: TextStyle(fontSize: 21.sp),
                            //  decoration: (item.inInterface == 'true' && item.newPrice != '') ? TextDecoration.lineThrough : null
                          ),
                          maxLines: 1,
                          minFontSize: 10,
                        ), // reduced-price

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          //item_desc
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    child: Text(item.desc!,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.almarai(
                          textStyle: TextStyle(fontSize: 20.sp),
                          height: 1.3,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            itemInfo(item),
          ],
        )),
      );
  }
}
