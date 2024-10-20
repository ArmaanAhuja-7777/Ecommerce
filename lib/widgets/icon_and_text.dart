import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/smallText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  final Color iconColor;
  final double size;
  const IconAndTextWidget(
      {Key? key,
      required this.icon,
      required this.text,
      this.size = 0,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: size == 0 ? Dimensions.iconSize : size,
        ),
        SizedBox(
          width: Dimensions.appColumnPaddingWidth2,
        ),
        smallText(
          text: text,
        )
      ],
    );
  }
}
