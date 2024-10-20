import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/app_lottie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final double height;
  final String imgLottiePath;
  const NoDataPage(
      {Key? key,
      required this.text,
      this.height = 0,
      this.imgLottiePath = 'assets/lottie/girl_empty.json'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // color: Colors.brown,
    return Container(
      // color: const Color.fromARGB(115, 244, 67, 54),
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment,
        children: [
          AppLottie(
            lottiePath: imgLottiePath,
            height: height == 0 ? Dimensions.lottieHeight400 : height,
            // height: MediaQuery.of(context).size.height * 0.22,
            // width: MediaQuery.of(context).size.height * 0.22,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.0175,
                color: Theme.of(context).disabledColor),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
