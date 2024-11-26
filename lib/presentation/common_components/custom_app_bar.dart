import 'package:flutter/material.dart';
import 'package:deliver_ease/core/utils/utils.dart';

import '../../core/utils/app_colors.dart';

AppBar customAppBar({
  required String title,
  String? keyName,
  Color titleColor = Colors.white,
  bool hasArrow = true,
  VoidCallback? onBackPressed,
  Widget? titleWidget,
  IconData backArrowIcon = Icons.arrow_back_ios,
  Color backArrowColor =  Colors.white,
  Color toolbarBackgroundColor = AppColors.primaryColor,
  List<Widget> actions = const [],
  String? fontFamily,
  bool centerTitle = true,
  PreferredSizeWidget? bottomWidget,
}) {
  return AppBar(

    leading: hasArrow
        ? IconButton(
      key: stringHasValue(keyName) ? Key(keyName!) : const Key("key"),
      onPressed: onBackPressed ??
              () {
            // Navigator.pop(context);
          },
      icon: Icon(
        backArrowIcon,
        color: backArrowColor,
      ),
    )
        : const SizedBox(),
    elevation: 0,
    title: titleWidget ??
        Text(
          title,
          style: TextStyle(
              color: titleColor,
              fontWeight: FontWeight.w600,
              fontFamily: fontFamily ?? ''),
        ),
    backgroundColor: toolbarBackgroundColor,
    actions: actions,
    centerTitle: centerTitle,
    bottom: bottomWidget,
  );
}