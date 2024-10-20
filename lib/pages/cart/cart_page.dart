import 'package:e_commerce/base/no_data_page.dart';
import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/controllers/popular_product_controller.dart';
import 'package:e_commerce/controllers/recommended_product_controller.dart';
import 'package:e_commerce/main.dart';
import 'package:e_commerce/pages/home/main_food_page.dart';
import 'package:e_commerce/presentation/texts.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/utils/app_constants.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/app_icon.dart';
import 'package:e_commerce/widgets/bigText.dart';
import 'package:e_commerce/widgets/smallText.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../presentation/colors.dart';
import '../../utils/durations.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              left: Dimensions.width_width20,
              right: Dimensions.width_width20,
              top: Dimensions.height20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    icon: Icons.arrow_back,
                  ),
                  SizedBox(
                    width: Dimensions.width_width20 * 7,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(
                      icon: Icons.home,
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart_outlined,
                  ),
                ],
              )),
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getItems.length > 0
                ? Positioned(
                    top: Dimensions.height20 * 4,
                    left: Dimensions.width_width20,
                    right: Dimensions.width_width20,
                    bottom: 0,
                    child: Container(
                      margin: EdgeInsets.only(top: Dimensions.height10),
                      child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: GetBuilder<CartController>(
                            builder: (cartController) {
                              var _cartList = cartController.getItems;
                              return ListView.builder(
                                  itemCount: _cartList.length,
                                  itemBuilder: (_, index) {
                                    //wrap this with gesture detector
                                    return Container(
                                      // color: Colors.blue,
                                      height: Dimensions.height20 * 5,
                                      width: double.maxFinite,
                                      child: Row(children: [
                                        GestureDetector(
                                          onTap: () {
                                            var popularIndex = Get.find<
                                                    PopularProductController>()
                                                .popularProductList
                                                .indexOf(
                                                    _cartList[index].product!);
                                            if (popularIndex >= 0) {
                                              Get.toNamed(
                                                  RouteHelper.getPopularFood(
                                                      popularIndex,
                                                      "cartpage"));
                                            } else {
                                              var recommendedIndex = Get.find<
                                                      RecommendedProductController>()
                                                  .recommendedProductList
                                                  .indexOf(_cartList[index]
                                                      .product!);
                                              if (recommendedIndex < 0) {
                                                Get.snackbar("History Product",
                                                    "Product review is not available for history product",
                                                    backgroundColor:
                                                        AppColors.errorColor,
                                                    colorText:
                                                        AppColors.mainTextColor,
                                                    margin: EdgeInsets.only(
                                                        top: Dimensions
                                                            .height15),
                                                    duration: Duration(
                                                        seconds: AppDurations
                                                            .snackbarDuration));
                                              } else {
                                                Get.toNamed(RouteHelper
                                                    .getRecommendedFood(
                                                        recommendedIndex,
                                                        'cartpage'));
                                              }
                                            }
                                          },
                                          child: Container(
                                            width: Dimensions.height20 * 5,
                                            height: Dimensions.height20 * 5,
                                            margin: EdgeInsets.only(
                                                bottom: Dimensions.height10),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        AppConstants
                                                                .UPLOAD_URL +
                                                            cartController
                                                                .getItems[index]
                                                                .img!)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius20),
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          width: Dimensions.width_width10,
                                        ),
                                        Expanded(
                                            child: Container(
                                          height: Dimensions.height20 * 5,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                bigText(
                                                    text: cartController
                                                        .getItems[index].name!),
                                                smallText(text: "spicy"),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    bigText(
                                                      text: cartController
                                                          .getItems[index].price
                                                          .toString(),
                                                      color: Colors.red,
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          top: Dimensions
                                                              .bottomNavPadding,
                                                          bottom: Dimensions
                                                              .bottomNavPadding,
                                                          left: Dimensions
                                                              .buttonPaddingWidth10,
                                                          right: Dimensions
                                                              .buttonPaddingWidth10),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  Dimensions
                                                                      .radius20),
                                                          color: Colors.white),
                                                      child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                cartController.addItem(
                                                                    _cartList[
                                                                            index]
                                                                        .product!,
                                                                    -1);
                                                              },
                                                              child: Icon(
                                                                Icons.remove,
                                                                color: AppColors
                                                                    .iconColor3,
                                                                size: Dimensions
                                                                    .iconsize24,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: Dimensions
                                                                  .width10,
                                                            ),
                                                            Transform.translate(
                                                              offset: Offset(
                                                                  0,
                                                                  -Dimensions
                                                                      .addItemsNumberOffset),
                                                              child: bigText(
                                                                text: _cartList[
                                                                        index]
                                                                    .quantity
                                                                    .toString(),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: Dimensions
                                                                  .width10,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                cartController.addItem(
                                                                    _cartList[
                                                                            index]
                                                                        .product!,
                                                                    1);
                                                                print(
                                                                    "add is being tapped");
                                                              },
                                                              child: Icon(
                                                                Icons.add,
                                                                color: AppColors
                                                                    .iconColor3,
                                                                size: Dimensions
                                                                    .iconsize24,
                                                              ),
                                                            ),
                                                          ]),
                                                    ),
                                                  ],
                                                )
                                              ]),
                                        ))
                                      ]),
                                    );
                                  });
                            },
                          )),
                    ))
                : NoDataPage(text: "Your cart is empty!");
          })
        ],
      ),

      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartController) {
          return cartController.getItems.length > 0
              ? Container(
                  height: Dimensions.bottomNavHeight,
                  padding: EdgeInsets.only(
                      top: Dimensions.bottomNavContPadding,
                      bottom: Dimensions.bottomNavContPadding,
                      left: Dimensions.ButtonPaddingWidth,
                      right: Dimensions.ButtonPaddingWidth),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radius20 * 2),
                          topRight: Radius.circular(Dimensions.radius20 * 2)),
                      color: AppColors.bottomNavColor),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: Dimensions.bottomNavPadding,
                              bottom: Dimensions.bottomNavPadding,
                              left: Dimensions.buttonPaddingWidth10,
                              right: Dimensions.buttonPaddingWidth10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              color: Colors.white),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                bigText(
                                  text: cartController.totalAmount.toString() +
                                      " Rs.",
                                ),
                              ]),
                        ),
                        SizedBox(
                          width: Dimensions.buttonPaddingWidth10,
                        ),
                        GestureDetector(
                          onTap: () {
                            // popularProduct.addItem(product);
                            print("tapped");
                            cartController.addToHistory();
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                top: Dimensions.bottomNavPadding,
                                bottom: Dimensions.bottomNavPadding,
                                left: Dimensions.buttonPaddingWidth10,
                                right: Dimensions.buttonPaddingWidth10),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                color: AppColors.addToCartButtonFaded),
                            child: bigText(
                              text: AppTexts.checkout,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ]),
                )
              : Container(
                  // color: Colors.red,
                  height: Dimensions.height10 / 2,
                );
        },
      ),
    );
  }
}
