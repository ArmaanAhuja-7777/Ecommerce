import 'package:e_commerce/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/presentation/colors.dart';

class bigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  bigText(
      {Key? key,
      this.color = const Color.fromARGB(255, 0, 0, 0),
      required this.text,
      this.size = 0,
      this.overflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontFamily: 'Roboto',
          fontSize: size == 0 ? Dimensions.font20 : size),
    );
  }
}
