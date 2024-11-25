import 'package:flutter/material.dart';

import '../text_view.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog(
      {super.key,
        required this.title,
        required this.description,
        this.firstButtonText = 'Ok',
        this.secondButtonText = 'Cancel',
        this.backgroundColor,
        this.firstButtonTextColor,
        this.secondButtonTextColor,
        this.dialogBorderRadius,
        this.firstButtonClick,
        this.secondButtonClick,
        this.isSecondButton = true,
        this.padding});

  final String title, description;
  final String? firstButtonText, secondButtonText;
  final Color? backgroundColor, firstButtonTextColor, secondButtonTextColor;
  final double? dialogBorderRadius;
  final bool isSecondButton;
  final VoidCallback? firstButtonClick, secondButtonClick;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: backgroundColor ?? Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(dialogBorderRadius ?? 10.0),
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15),
            TextView(
              title: title,
              fontSize: 17,
              fontFamily: '',

            ),
            // const SizedBox(height: 15),
            // TextView(
            //   title: description,
            //   fontSize: 15,
            //   maxLine: 4,
            //   textAlign: TextAlign.center,
            // ),
            const SizedBox(height: 20),
            const Divider(
              height: 1,
            ),
            TextView(
              title: firstButtonText ?? 'Ok',
              height: 50,
              width: MediaQuery.of(context).size.width,
              fontSize: 18,
              alignment: Alignment.center,
              textColor: firstButtonTextColor ?? Colors.blue,
              onPressed: firstButtonClick,
            ),
            isSecondButton
                ? const Divider(
              height: 1,
            )
                : Container(),
            isSecondButton
                ? TextView(
              title: secondButtonText ?? 'Cancel',
              alignment: Alignment.center,
              height: 50,
              width: MediaQuery.of(context).size.width,
              fontSize: 18,
              textColor: secondButtonTextColor ?? Colors.black,
              onPressed: secondButtonClick,
            )
                : const SizedBox.shrink(),
            /*Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 50,
              child: InkWell(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
                highlightColor: Colors.grey[200],
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Center(
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}