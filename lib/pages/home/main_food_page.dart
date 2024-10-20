import 'package:e_commerce/pages/home/food_page_body.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/bigText.dart';
import 'package:e_commerce/widgets/smallText.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/presentation/colors.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        //showing the header
        Container(
          child: Container(
            padding: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            margin: EdgeInsets.only(
                top: Dimensions.height15, bottom: Dimensions.height15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    bigText(
                      text: "India",
                      color: AppColors.themeTextColor,
                      size: Dimensions.height30,
                    ),
                    Row(children: [
                      smallText(
                        text: "Punjab",
                        size: Dimensions.height15,
                        color: AppColors.mainTextColor,
                      ),
                      Icon(Icons.arrow_drop_down)
                    ])
                  ],
                ),
                Center(
                  child: Container(
                    width: Dimensions.mainFoodPageIconHeight_width,
                    height: Dimensions.mainFoodPageIconHeight_width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.height15),
                      color: AppColors.searchButtonColor,
                    ),
                    child: Icon(
                      Icons.search,
                      color: AppColors.iconColor,
                      size: Dimensions.iconSize,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        // showing the body
        Expanded(
            child: SingleChildScrollView(
          child: FoodPageBody(),
        )),
      ],
    ));
  }
}
