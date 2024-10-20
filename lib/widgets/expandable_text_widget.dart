import 'package:e_commerce/presentation/colors.dart';
import 'package:e_commerce/presentation/texts.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/smallText.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({super.key, required this.text});

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight / 5.63;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? smallText(text: firstHalf)
          : Column(
              children: [
                Text(
                  hiddenText ? firstHalf + "..." : (firstHalf + secondHalf),
                  style: TextStyle(letterSpacing: 1.0),
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      smallText(
                        text:
                            hiddenText ? AppTexts.showMore : AppTexts.showLess,
                        color: AppColors.themeColor,
                        // size: Dimensions.font20,
                      ),
                      Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: AppColors.themeColor,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
