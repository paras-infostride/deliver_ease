import 'package:deliver_ease/core/utils/responsive_util.dart';
import 'package:deliver_ease/presentation/common_components/text_view.dart';
import 'package:flutter/material.dart';
class NoVerifiedView extends StatelessWidget {
  const NoVerifiedView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/verified.png",
              height: Responsive.setWidth( 180),
              width: Responsive.setWidth( 180),
              fit: BoxFit.fill,
            ),

            const TextView(
              // margin: EdgeInsets.only(top: size.height * 0.04),
              title: 'Verification required!!\nContact admin to get verified',
              fontSize: 18,
              maxLine: 4,
              textAlign: TextAlign.center,
              // fontFamily: getAppConfig().appFontResource.bold,
            ),
          ],
        ));
  }
}