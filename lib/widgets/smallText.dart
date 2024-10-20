import 'package:e_commerce/utils/dimensions.dart';
import 'package:flutter/material.dart';

class smallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  double height;
  var weight;
  smallText(
      {Key? key,
      this.color = const Color.fromARGB(255, 0, 0, 0),
      required this.text,
      this.size = 0,
      this.overflow = TextOverflow.ellipsis,
      this.height = 1.2,
      this.weight = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: size == 0 ? Dimensions.smallTextHeight12 : size,
          fontWeight: weight == 0 ? FontWeight.w200 : weight,
          color: color,
          height: height),
    );
  }
}
