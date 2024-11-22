import 'package:deliver_ease/presentation/common_components/text_view.dart';
import 'package:flutter/material.dart';

import 'package:deliver_ease/core/utils/utils.dart';


class AppOutlinedButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final double? width;
  final double height;
  final double radius;
  final Function() onTap;
  final Color outlineColor;
  final Color bkgColor;
  final Color txtColor;
  final Widget? child;
  final EdgeInsets margin;
  final EdgeInsets? padding;

  const AppOutlinedButton(
      {super.key,
        required this.text,
        required this.onTap,
        this.outlineColor = Colors.black,
        this.bkgColor = Colors.transparent,
        this.txtColor = Colors.black,
        this.height = 52,
        this.fontSize = 18,
        this.child,
        this.width,
        this.radius = 200,
        this.margin = EdgeInsets.zero,
        this.padding = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: margin,
      width: width ?? size.width * .41,
      // height: height,
      child: ButtonTheme(
        // minWidth: 250,
        // minWidth: width ??  size.width * .41,

        // height: size.height * .06,
        child: Transform.scale(
          scaleY: 0.9,
          child: OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              backgroundColor: bkgColor,
              padding: EdgeInsets.zero,
              fixedSize: Size.fromHeight(height),
              side: BorderSide(color: outlineColor, width: 1.2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(radius))),
            ),
            child: child ??
                TextView(
                  padding: padding,
                  fontSize: fontSize,
                  title: text,
                  textColor: txtColor,
                  fontWeight: FontWeight.w600,
                  fontFamily: "",
                ),
          ),
        ),
      ),
    );
  }
}