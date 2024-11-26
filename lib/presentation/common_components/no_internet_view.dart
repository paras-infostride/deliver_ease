import 'package:deliver_ease/core/utils/responsive_util.dart';
import 'package:deliver_ease/presentation/common_components/text_view.dart';
import 'package:flutter/material.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/no-internet.png",
              height: Responsive.setWidth( 180),
              width: Responsive.setWidth( 180),
              fit: BoxFit.fill,
            ),
            TextView(
              margin: EdgeInsets.only(top: size.height * 0.04),
              title: 'No Internet Connection',
              fontSize: 18,
              // fontFamily: getAppConfig().appFontResource.bold,
            ),
          ],
        ));
  }
}