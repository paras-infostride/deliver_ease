// import 'package:deliver_ease/core/utils/debug_logger.dart';
// import 'package:deliver_ease/core/utils/text_style_constants.dart';

import 'package:deliver_ease/core/utils/utils.dart';
import 'package:deliver_ease/presentation/common_components/text_view.dart';
import 'package:flutter/material.dart';




class ErrorView extends StatelessWidget {
  final String message;
  final double? height;
  final Color color;
  final Function()? onRetry;

  const ErrorView(
      {Key? key,
        required this.message,
        this.onRetry,
        this.height,
        this.color = Colors.transparent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    debuggerAdvance(tag: 'Error View', value: message);
    return Container(
      color: color,
      height: height,
      width: double.infinity,
      alignment: Alignment.center,
      child: Builder(
        builder: (context) {
          if (message.toString() == "Internal Server Error") {
            return FlutterLogo();
            // return InternalServererrorView(
            //   onTap: () {
            //     if (onRetry != null) {
            //       onRetry!();
            //     }
            //   },
            // );
          } else if (message == 'no_internet_connection') {
            return FlutterLogo();

          } else {
            return TextView(
              title: message,
              maxLine: 5,
              padding: const EdgeInsets.symmetric(
                  horizontal: 20),
              style: AppTextStyle.get18regular(),
            );
          }
        },
      ),
    );
  }
}