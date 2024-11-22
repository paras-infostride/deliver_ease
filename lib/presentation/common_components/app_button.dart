import 'package:deliver_ease/presentation/common_components/text_view.dart';
import 'package:flutter/material.dart';
import 'package:deliver_ease/core/utils/utils.dart';

class AppButton extends StatelessWidget {
  final double? height;
  final double? width;
  final String title;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final VoidCallback onPressed;
  final Color? buttonBackgroundColor;
  final double? borderRadius;
  final double? textFontSize;
  final Color? textColor;
  final String? textFontFamily;
  final FontWeight fontWeight;
  final Widget? child;

  const AppButton(
      {Key? key,
        this.height,
        this.width = double.infinity,
        required this.title,
        this.margin =
        const EdgeInsets.only(top: 24, bottom: 24, left: 20, right: 20),
        this.padding = const EdgeInsets.only(bottom: 10),
        required this.onPressed,
        this.buttonBackgroundColor,
        this.child,
        this.borderRadius = 6.0,
        this.textFontSize = 16,
        this.textColor = Colors.white,
        this.textFontFamily,
        this.fontWeight = FontWeight.w600})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonBackgroundColor ,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius!)),
        ),
        child: child ??
            TextView(
              fontWeight: fontWeight,
              alignment: Alignment.center,
              title: title,
              fontSize: textFontSize!,
              textColor: textColor!,
              fontFamily: textFontFamily,
            ),
      ),
    );
  }
}