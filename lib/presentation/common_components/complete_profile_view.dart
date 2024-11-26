import 'package:deliver_ease/core/routes/app_router.dart';
import 'package:deliver_ease/core/routes/app_routes_name.dart';
import 'package:deliver_ease/core/utils/app_dimesnions.dart';
import 'package:deliver_ease/core/utils/responsive_util.dart';
import 'package:deliver_ease/presentation/common_components/app_button.dart';
import 'package:deliver_ease/presentation/common_components/text_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';




class CompleteProfileView extends StatelessWidget {
  final Function() onTap;
  const CompleteProfileView({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/user.png",
              height: Responsive.setWidth( 180),
              width: Responsive.setWidth( 180),
              fit: BoxFit.fill,
            ),
             TextView(
              margin: EdgeInsets.only(top: size.height * 0.04),
              title: 'Complete profile!!\nTo avail service',
              fontSize: 18,
              maxLine: 4,
              textAlign: TextAlign.center,
              // fontFamily: getAppConfig().appFontResource.bold,
            ),
        AppButton(title: "Complete profile",
            width: Responsive.setWidthByPercentage(AppDimesnions.actionButtonWidth),
            margin: const EdgeInsets.only(top: 40),
            onPressed: () {
             onTap();

        })
      ],
        ));
  }
}