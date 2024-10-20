import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/controllers/popular_product_controller.dart';
import 'package:e_commerce/models/products_model.dart';
import 'package:e_commerce/pages/cart/cart_page.dart';
import 'package:e_commerce/pages/home/main_food_page.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/utils/app_constants.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/utils/durations.dart';
import 'package:e_commerce/widgets/app_column.dart';
import 'package:e_commerce/widgets/app_icon.dart';
import 'package:e_commerce/widgets/expandable_text_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:e_commerce/presentation/colors.dart';
import 'package:e_commerce/presentation/texts.dart';
import 'package:e_commerce/widgets/bigText.dart';
import 'package:e_commerce/widgets/smallText.dart';
import 'package:e_commerce/widgets/icon_and_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    // print("page id is:" + pageId.toString());
    // print("product name is " + product.name.toString());
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            AppConstants.UPLOAD_URL + product.img!))),
              )),
          Positioned(
              top: Dimensions.width20,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        if (page == 'cartpage') {
                          Get.toNamed(RouteHelper.getCartPage());
                        } else {
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: AppIcon(icon: Icons.arrow_back_outlined)),
                  GetBuilder<PopularProductController>(
                    builder: (controller) {
                      return GestureDetector(
                        onTap: () {
                          if (controller.totalItems >= 1) {
                            Get.toNamed(RouteHelper.getCartPage());
                          } else {
                            Get.snackbar(
                              "Add items",
                              "First add items to cart",
                              duration: Duration(
                                  seconds: AppDurations.snackbarDuration),
                              backgroundColor: AppColors.errorColor,
                              colorText: AppColors.mainTextColor,
                              margin: EdgeInsets.only(top: Dimensions.height15),
                            );
                          }
                        },
                        child: Stack(
                          children: [
                            AppIcon(icon: Icons.shopping_cart_outlined),
                            controller.totalItems >= 1
                                ? Positioned(
                                    right: 0,
                                    top: 0,
                                    child: AppIcon(
                                      icon: Icons.circle,
                                      size: Dimensions.height20,
                                      iconColor: Colors.transparent,
                                      backgroundColor:
                                          AppColors.cartItemsShowColor,
                                    ),
                                  )
                                : Container(),
                            Get.find<PopularProductController>().totalItems >= 1
                                ? Positioned(
                                    right: Dimensions.right6,
                                    top: Dimensions.top1,
                                    child: bigText(
                                      text: Get.find<PopularProductController>()
                                          .totalItems
                                          .toString(),
                                      size: Dimensions.font12,
                                      color: AppColors.mainTextColor,
                                    ))
                                : Container()
                          ],
                        ),
                      );
                    },
                  )
                ],
              )),
          Positioned(
              left: 0,
              right: 0,
              top: Dimensions.popularFoodImgSize - 20,
              bottom: 0,
              child: Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      top: Dimensions.height20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColumn(
                        text: product.name!,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      bigText(text: AppTexts.introduce),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child:
                              ExpandableTextWidget(text: product.description!),
                        ),
                      )
                    ],
                  ))),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct) {
          return Container(
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
                        children: [
                          GestureDetector(
                            onTap: () {
                              popularProduct.setQuantity(false);
                            },
                            child: Icon(
                              Icons.remove,
                              color: AppColors.iconColor3,
                              size: Dimensions.iconsize24,
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.width10,
                          ),
                          Transform.translate(
                            offset: Offset(0, -Dimensions.addItemsNumberOffset),
                            child: bigText(
                              text: popularProduct.inCartItems.toString(),
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.width10,
                          ),
                          GestureDetector(
                            onTap: () {
                              popularProduct.setQuantity(true);
                            },
                            child: Icon(
                              Icons.add,
                              color: AppColors.iconColor3,
                              size: Dimensions.iconsize24,
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(
                    width: Dimensions.buttonPaddingWidth10,
                  ),
                  GestureDetector(
                    onTap: () {
                      popularProduct.addItem(product);
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
                        text: "${product.price!} Rs. | Add to cart",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]),
          );
        },
      ),
    );
  }
}
