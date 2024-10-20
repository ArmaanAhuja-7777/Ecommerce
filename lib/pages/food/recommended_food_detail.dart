import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/controllers/popular_product_controller.dart';
import 'package:e_commerce/controllers/recommended_product_controller.dart';
import 'package:e_commerce/pages/cart/cart_page.dart';
import 'package:e_commerce/presentation/colors.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/utils/app_constants.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/app_icon.dart';
import 'package:e_commerce/widgets/bigText.dart';
import 'package:e_commerce/widgets/expandable_text_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/durations.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetail(
      {Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
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
                    child: AppIcon(
                      icon: Icons.clear,
                    ),
                  ),
                  //AppIcon(icon: Icons.shopping_cart)
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
                            Get.find<PopularProductController>().totalItems >= 1
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
                ]),
            pinned: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFFe8e8e8),
                            offset: Offset(0, Dimensions.boxShadowheight5),
                            blurRadius: 5.0),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-Dimensions.boxShadowheight5, 0),
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(Dimensions.boxShadowheight5, 0),
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radius20),
                          topRight: Radius.circular(Dimensions.radius20))),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  child: Center(
                      child: bigText(
                          text: product.name!, size: Dimensions.font26))),
            ),
            backgroundColor: AppColors.themeColorLight,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.UPLOAD_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: Dimensions.PaddingWidth,
                    right: Dimensions.PaddingWidth),
                child: ExpandableTextWidget(
                  text: product.description!,
                ),
              )
            ],
          ))
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (controller) {
        return Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            padding: EdgeInsets.only(
                left: Dimensions.PaddingWidth * 2.5,
                right: Dimensions.PaddingWidth * 2.5,
                top: Dimensions.height20,
                bottom: Dimensions.height20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.setQuantity(false);
                  },
                  child: AppIcon(
                    icon: Icons.remove,
                    backgroundColor: AppColors.themeColor,
                    iconColor: AppColors.iconColor,
                  ),
                ),
                bigText(
                    text:
                        " ${product.price!} Rs. x  ${controller.inCartItems} "),
                GestureDetector(
                  onTap: () {
                    controller.setQuantity(true);
                  },
                  child: AppIcon(
                    icon: Icons.add,
                    backgroundColor: AppColors.themeColor,
                    iconColor: AppColors.iconColor,
                  ),
                )
              ],
            ),
          ),
          Container(
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
                          left: Dimensions.bottomNavPadding,
                          right: Dimensions.bottomNavPadding),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.themeColor,
                      )),
                  GestureDetector(
                    onTap: () {
                      controller.addItem(product);
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
                        text: "${product.price} Rs. | Add to cart",
                        color: Colors.white,
                      ),
                    ),
                  )
                ]),
          ),
        ]);
      }),
    );
  }
}
