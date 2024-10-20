import 'package:e_commerce/presentation/colors.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/bigText.dart';
import 'package:e_commerce/widgets/icon_and_text.dart';
import 'package:e_commerce/widgets/smallText.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final double textSize;
  const AppColumn({super.key, required this.text, this.textSize = 0});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      bigText(
        text: text,
        size: textSize == 0 ? Dimensions.font26 : textSize,
      ),
      SizedBox(
        height: Dimensions.sizedBoxHeight10,
      ),
      Row(
        children: [
          Wrap(
            children: List.generate(
                5,
                (index) => Icon(
                      Icons.star,
                      color: AppColors.themeColor,
                      size: Dimensions.height15,
                    )),
          ),
          SizedBox(
            width: Dimensions.buttonPaddingWidth10,
          ),
          smallText(text: "4.5"),
          SizedBox(
            width: Dimensions.buttonPaddingWidth10,
          ),
          smallText(text: "1287"),
          SizedBox(
            width: Dimensions.appColumnPaddingWidth2,
          ),
          smallText(text: "Comments")
        ],
      ),
      SizedBox(
        height: Dimensions.height10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconAndTextWidget(
              icon: Icons.circle_sharp,
              text: "Normal",
              iconColor: AppColors.themeColor),
          // SizedBox(
          //   width: 10,
          // ),
          IconAndTextWidget(
              icon: Icons.location_on,
              text: "1.7km",
              iconColor: AppColors.iconColor1),
          // SizedBox(
          //   width: 10,
          // ),
          IconAndTextWidget(
              icon: Icons.access_time_rounded,
              text: "30mins",
              iconColor: AppColors.iconColor2)
        ],
      )
    ]);
  }
}
