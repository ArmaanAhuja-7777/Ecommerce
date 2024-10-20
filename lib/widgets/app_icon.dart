import 'package:e_commerce/presentation/colors.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;
  const AppIcon(
      {Key? key,
      required this.icon,
      this.backgroundColor = const Color.fromARGB(255, 255, 170, 0),
      this.iconColor = const Color.fromARGB(255, 0, 0, 0),
      this.size = 0,
      this.iconSize = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _sizefinal = size == 0 ? Dimensions.iconBackgroundSize : size;
    return Container(
      height: _sizefinal,
      width: _sizefinal,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_sizefinal / 2),
          color: backgroundColor),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize == 0 ? Dimensions.iconsize24 : iconSize,
      ),
    );
  }
}
