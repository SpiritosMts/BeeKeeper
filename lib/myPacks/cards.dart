
import 'package:beekeeper/models/itemModel.dart';
import 'package:beekeeper/models/requestModel.dart';
import 'package:beekeeper/myPacks/myConstants.dart';
import 'package:beekeeper/myPacks/myTheme/myTheme.dart';
import 'package:beekeeper/shop/ItemView.dart';
import 'package:beekeeper/shop/shopCtr.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:ionicons/ionicons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

double itemCategCardW = 50.w;
//double itemCategCardH = 25.h;
double itemCategImgW = 50.w;
double itemCategImgH = 18.h;
double opacityCol = .3;


Widget shimmerImage(url,{double h=300,double w=300}){
  return FancyShimmerImage(
    shimmerDirection: ShimmerDirection.ltr,
    //boxFit: BoxFit.cover,
    width: w,
    height: h,
    imageUrl: url,
    shimmerBaseColor: blueColHex ,
    shimmerHighlightColor: yellowCol.withOpacity(0.2),
    shimmerBackColor: blueColHex,
    errorWidget: noSpecificImage(),
  );
}



Widget noSpecificImage(){
  return Image.asset('assets/images/logo.png',color: yellowCol.withOpacity(0.5));
}






/// item Card
itemCard(Item item) {
  return       GestureDetector(

    onTap: () {
      Get.find<ShopCtr>().selectItem(item);
      Get.to(() => ItemView(),);
    },
    child: Stack(
      children: [
        SizedBox(
          width: itemCategCardW,
          //height: 300,
          child: Card(
            color: blueColHex2,
            margin: const EdgeInsets.all(5.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            shadowColor: Colors.white24,
            child: SizedBox(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// image
                    Container(
                      padding: const EdgeInsets.only(bottom: 0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(15), bottom: Radius.circular(15)),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(15), bottom: Radius.circular(8)),
                        child: SizedBox(
                          width: itemCategImgW,
                          height: itemCategImgH,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            //size: Size.fromRadius(30),
                            child: item.imageUrl! != '' ?
                            shimmerImage(item.imageUrl!) :
                            noSpecificImage(),
                          ),
                        ),
                      ),
                    ),
                    /// under_image
                    Container(
                      //color: Colors.green.withOpacity(opacityCol),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: item.newPrice != '' ? 5 : 11, top: 0, right: 10, left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // item_name
                            Flexible(
                              child: Text(
                                item.name!,
                                textDirection: TextDirection.rtl,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: GoogleFonts.almarai(textStyle: const TextStyle(fontWeight: FontWeight.w600), fontSize: 17.sp),
                              ),
                            ),

                            // item_price
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${item.price} " + "dt",
                                    textDirection: TextDirection.ltr,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: GoogleFonts.almarai(
                                      decoration: (item.newPrice != '') ? TextDecoration.lineThrough : null,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  if (item.newPrice != '')
                                    Text(
                                      "${item.newPrice} " + "dt",
                                      textDirection: TextDirection.ltr,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        color: yellowColHex,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

}


Widget GridItemList(itemsList) {
  return itemsList.isNotEmpty
      ? GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 7),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1,
            crossAxisCount: 2,
          ),
          itemCount: itemsList.length,
          itemBuilder: (BuildContext ctx, index) {
            return itemCard(itemsList[index]); // Item (Grid)
          })
      : Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Center(
            child: Text('no items found'.tr,
              textAlign: TextAlign.start,
              style: GoogleFonts.almarai(
                fontSize: 19.sp,
              ),),
          ),
        );
}


// Widget requestCard(ctx, AsyncSnapshot<List<Requestb>> snapshot) {
//
//   return snapshot.data!.map((rq) {
//     String acceptedState = '';
//     switch (rq.accepted) {
//       case "yes":
//         acceptedState = 'accepted'.tr;
//         break;
//       case "no":
//         acceptedState = 'refused'.tr;
//         break;
//       default://'notYet'
//         acceptedState = 'review'.tr;
//     }
//     return Stack(
//       children: [
//         GestureDetector(
//           onTap: () {
//           },
//           child: Container(
//             //color: Colors.green,
//
//             child: SizedBox(
//
//               height: 150,
//               child: Card(
//                 color: blueColHex2,
//
//                 margin: const EdgeInsets.all(8.0),
//                 elevation: 3,
//                 child:Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     /// name
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(0.0, 21.0, 17.0, 10.0),
//                       child: SizedBox(
//                         width: 50.w,
//                         child: Text('${store.name}',
//                             maxLines: 1,
//                             style:  TextStyle(
//
//                               fontWeight: FontWeight.bold,
//                               fontSize: 21.sp,
//                             )
//                         ),
//                       ),
//                     ),
//                     /// rating
//                     Container(
//                       //color: Colors.red,
//                       child: Padding(
//                         padding: const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 0.0),
//                         child: SizedBox(
//                           width: 80,
//                           height: 70,
//                           child: Column(
//                             //crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               ///rating
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   //stars.toStringAsFixed(1)
//                                   Text('${store.stars}', style: const TextStyle(fontSize: 20)),
//                                   const Icon(
//                                     Icons.star,
//                                     color: Colors.amber,
//                                     size: 25,
//                                   ),
//                                 ],
//                               ), //star
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               ///_raters
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Icon(Icons.person, color: Colors.white70, size: 13), //person
//
//                                   Text("(${store.raterCount})", style: const TextStyle(fontSize: 11)),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//               ),
//             ),
//           ),
//         ),
//         //buttons
//         Positioned(
//           bottom: 20,
//           right: 20,
//           child: Row(
//             children: [
//               SizedBox(
//                 //width: width / 7,
//                 child: TextButton(
//                   style: ylwStyle,
//                   onPressed: () {
//                     homeCtr.selectStToModify(store);
//                     goEditStoreInfo();
//                   },
//                   child: Text("edit".tr,
//                       style: GoogleFonts.almarai(
//                         color: Theme.of(context).backgroundColor,
//                         textStyle: const TextStyle(fontSize: 15),
//                       )),
//                 ),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               SizedBox(
//                 //width: width / 4,
//                 child: TextButton(
//                   style: ylwStyle,
//                   onPressed: () {
//                     homeCtr.selectStToModify(store);
//                     goEditStoreProducts();
//                   },
//                   child: Text("products".tr,
//                       style: GoogleFonts.almarai(
//                         color: Theme.of(context).backgroundColor,
//                         textStyle: const TextStyle(fontSize: 15),
//                       )),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }).toList();
// }
