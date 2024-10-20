import 'package:e_commerce/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppLottie extends StatelessWidget {
  final String lottiePath;
  // final double width;
  final double height;
  const AppLottie({key, required this.lottiePath, this.height = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Lottie.asset(lottiePath,
          // width: width == 0 ? Dimensions.lottieWidth300 : width,
          height: height == 0 ? Dimensions.lottieHeight400 : height,
          fit: BoxFit.fill),
    );
  }
}
