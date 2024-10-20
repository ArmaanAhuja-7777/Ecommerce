import 'dart:convert';
import 'dart:math';

import 'package:e_commerce/base/no_data_page.dart';
import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/presentation/colors.dart';
import 'package:e_commerce/presentation/texts.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/utils/app_constants.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/app_icon.dart';
import 'package:e_commerce/widgets/bigText.dart';
import 'package:e_commerce/widgets/smallText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../models/cart_model.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();

    var listCounter = 0;
    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("hh:mm a  |  dd/MM/yyyy");
        outputDate = outputFormat.format(inputDate);
      }
      return bigText(
        text: outputDate.toString(),
        size: Dimensions.font15,
        color: AppColors.textColorGreyish,
      );
    }

    return Scaffold(
      body: Column(children: [
        Container(
          height: Dimensions.height10 * 8,
          padding: EdgeInsets.only(top: Dimensions.height10),
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: AppColors.themeColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Dimensions.radius20),
                  bottomRight: Radius.circular(Dimensions.radius20))),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            bigText(
              text: AppTexts.cartHistory,
              size: Dimensions.font22,
            ),
            AppIcon(
                icon: Icons.shopping_cart_outlined,
                backgroundColor: Colors.white)
          ]),
        ),
        GetBuilder<CartController>(builder: (_cartController) {
          return _cartController.getCartHistoryList().length > 0
              ? Expanded(
                  child: Container(
                      margin: EdgeInsets.only(
                          top: Dimensions.height20,
                          left: Dimensions.width_width20,
                          right: Dimensions.width_width20),
                      child: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView(children: [
                          for (int i = 0; i < itemsPerOrder.length; i++)
                            Container(
                              height: Dimensions.height20 * 6,
                              margin:
                                  EdgeInsets.only(bottom: Dimensions.height20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // These are called iif: immediately invoked functions
                                    timeWidget(listCounter),
                                    SizedBox(
                                      height: Dimensions.height10 / 2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Wrap(
                                          direction: Axis.horizontal,
                                          children: List.generate(
                                              itemsPerOrder[i], (index) {
                                            if (listCounter <
                                                getCartHistoryList.length) {
                                              listCounter++;
                                            }
                                            return index <= 2
                                                ? Container(
                                                    height:
                                                        Dimensions.height10 * 8,
                                                    width:
                                                        Dimensions.height10 * 8,
                                                    margin: EdgeInsets.only(
                                                        right: Dimensions
                                                                .width_width10 /
                                                            2),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimensions
                                                                    .radius20),
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(AppConstants
                                                                    .UPLOAD_URL +
                                                                getCartHistoryList[
                                                                        listCounter -
                                                                            1]
                                                                    .img!))),
                                                  )
                                                : Container(
                                                    height:
                                                        Dimensions.height10 * 8,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          bigText(text: "...")
                                                        ]),
                                                  );
                                          }),
                                        ),
                                        Container(
                                          // height: 80,
                                          // color: Colors.red,
                                          // decoration: BoxDecoration(color: Colors.red),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                smallText(
                                                  text: AppTexts.total,
                                                  color: AppColors
                                                      .textColorGreyish,
                                                ),
                                                SizedBox(
                                                  height:
                                                      Dimensions.height10 / 5,
                                                ),
                                                bigText(
                                                  text: itemsPerOrder[i] != 1
                                                      ? itemsPerOrder[i]
                                                              .toString() +
                                                          " Items"
                                                      : itemsPerOrder[i]
                                                              .toString() +
                                                          " Item",
                                                  color:
                                                      AppColors.mainTextColor,
                                                ),
                                                SizedBox(
                                                  height:
                                                      Dimensions.height10 / 2,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    var orderTime =
                                                        cartOrderTimeToList();
                                                    Map<int, CartModel>
                                                        moreOrder = {};
                                                    for (int j = 0;
                                                        j <
                                                            getCartHistoryList
                                                                .length;
                                                        j++) {
                                                      if (getCartHistoryList[j]
                                                              .time ==
                                                          orderTime[i]) {
                                                        moreOrder.putIfAbsent(
                                                            getCartHistoryList[j]
                                                                .id!,
                                                            () => CartModel.fromJson(
                                                                jsonDecode(jsonEncode(
                                                                    getCartHistoryList[
                                                                        j]))));
                                                      }
                                                    }
                                                    Get.find<CartController>()
                                                        .setItems = moreOrder;
                                                    Get.find<CartController>()
                                                        .addToCartList();
                                                    Get.toNamed(RouteHelper
                                                        .getCartPage());
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: Dimensions
                                                            .width_width10,
                                                        vertical: Dimensions
                                                                .height10 /
                                                            2),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(Dimensions
                                                                    .radius20 /
                                                                4),
                                                        border: Border.all(
                                                            width: 2,
                                                            color: AppColors
                                                                .themeColor)),
                                                    child: smallText(
                                                      text: AppTexts.oneMore,
                                                      weight: FontWeight.w400,
                                                      color:
                                                          AppColors.themeColor,
                                                    ),
                                                  ),
                                                )
                                              ]),
                                        )
                                      ],
                                    )
                                  ]),
                            )
                        ]),
                      )),
                )
              : Container(
                  height: Dimensions.height500,
                  // color: Colors.red,
                  child: Center(
                    child: NoDataPage(
                        text: "You didn't buy anything so far",
                        imgLottiePath: "assets/lottie/empty-box.json",
                        height: Dimensions.lottieHeight300),
                  ),
                );
        })
      ]),
    );
  }
}
