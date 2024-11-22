import 'package:flutter/material.dart';

import '../text_view.dart';

/*
*
*   _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return InfoDialogView(message: message ,onPressed: ()
          {
            Get.back();
          },);
      },
    );
  }
* */

/*class InfoDialogView extends StatelessWidget {
  final String message;
  final Function? onPressed;

  const InfoDialogView(
      {Key? key, required this.message,  this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Dialog(
      child: Container(
          width: size.width * .85,
          height: size.height * .23,
          padding: const EdgeInsets.symmetric(horizontal: 13.0),
          child: Column(
            children: [
              const Spacer(
                flex: 2,
              ),
              TextView(
                title: message,
                fontSize: 20,
              ),
              const Spacer(
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      if(onPressed != null)
                        {
                          onPressed!();
                        }
                      else
                        {
                          Get.back();
                        }
                    },
                    child: const TextView(
                      title: AppStrings.ok,
                      fontSize: 17,
                      textColor: ColorConst.buttonColor,
                    ),
                  ),
                  // const SizedBox(
                  //   width: 50,
                  // ),
                ],
              ),
              const Spacer(),
            ],
          )),
    );
  }
}*/

class InfoDialogViewGet extends StatelessWidget {
  final String message;
  final Function? onPressed;

  const InfoDialogViewGet({Key? key, required this.message, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        width: size.width * .85,
        height: size.height * .18,
        padding: const EdgeInsets.symmetric(horizontal: 13.0),
        child: Column(
          children: [
            const Spacer(
              flex: 2,
            ),
            TextView(
              title: message,
              fontSize: 20,
            ),
            const Spacer(
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    if (onPressed != null) {
                      onPressed!();
                    } else {
                      // Get.back();
                    }
                  },
                  child: TextView(
                    title: 'ok',
                    fontSize: 17,
                    textColor: Colors.black,
                  ),
                ),
                // const SizedBox(
                //   width: 50,
                // ),
              ],
            ),
            const Spacer(),
          ],
        ));
  }
}