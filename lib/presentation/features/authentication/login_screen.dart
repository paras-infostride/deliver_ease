import 'package:deliver_ease/core/utils/responsive_util.dart';
import 'package:deliver_ease/core/utils/app_dimesnions.dart';
import 'package:deliver_ease/presentation/common_components/app_button.dart';
import 'package:deliver_ease/presentation/common_components/app_text_fields.dart';
import 'package:deliver_ease/presentation/common_components/text_view.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController.text = "+91";
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          AspectRatio(
            aspectRatio: 4 / 2,
            child: Image.asset(
              "assets/fast-delivery.png",
              width: 200,
              height: 200,
            ),
          ),
          const TextView(
            title: "DeliverEase",
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
          const Spacer(),
          AppTextField(
            context: context,
            onChanged: (String value) {},
            headingText: "Phone Number",
            keyboard: TextInputType.number,
            controller: _textEditingController,
            width:
                Responsive.setWidthByPercentage(AppDimesnions.textFieldWidth),
          ),
          const SizedBox(
            height: 30,
          ),
          AppButton(
            title: "Submit",
            onPressed: () {},
            width: Responsive.setWidthByPercentage(
                AppDimesnions.actionButtonWidth),
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
