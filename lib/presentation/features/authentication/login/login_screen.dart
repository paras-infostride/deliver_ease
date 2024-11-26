import 'package:deliver_ease/core/routes/app_router.dart';
import 'package:deliver_ease/core/routes/app_routes_name.dart';
import 'package:deliver_ease/core/utils/list_utility.dart';
import 'package:deliver_ease/core/utils/responsive_util.dart';
import 'package:deliver_ease/core/utils/app_dimesnions.dart';
import 'package:deliver_ease/core/utils/utils.dart';
import 'package:deliver_ease/presentation/common_components/app_button.dart';
import 'package:deliver_ease/presentation/common_components/app_text_fields.dart';
import 'package:deliver_ease/presentation/common_components/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_components/dialog/info_dialog.dart';
import 'login_controller.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

  late TextEditingController _textEditingController;

  final _formKey = GlobalKey<FormState>();
  
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
   LoginScreenState loginScreenState = ref.watch(loginControllerProvider);

    ref.listen<LoginScreenState>(loginControllerProvider, ( prev, next) {

      if(prev != next  && stringHasValue(next.hasMessage))
        {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return InfoDialogViewGet(message: next.hasMessage ,
             onPressed: ()
                {
                  Navigator.of(context).pop();
                },

              );
            },
          );
        }

      if(prev != next  && next.apiTriggerSuccess == true && stringHasValue(next.verificationID))
        {
          context.goNamed(AppRoutesName.otpVerifyScreen,
           extra: {
           'verificationID': next.verificationID,
         },);

        }

    });
    
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
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
               maxLimit: 13,
              keyboard: TextInputType.number,
              controller: _textEditingController,
              width: Responsive.setWidthByPercentage(AppDimesnions.textFieldWidth),
              validator: Validator.validateMobileNo,
            ),
            const SizedBox(
              height: 30,
            ),
            loginScreenState.showLoader  ? const CircularProgressIndicator() :   AppButton(
              title: "Submit",
              onPressed: () {


                if (_formKey.currentState!.validate()) {
                  ref.read(loginControllerProvider.notifier).submitPhoneNumber(phoneNumber: _textEditingController.text);
                }

              },
              width: Responsive.setWidthByPercentage(
                  AppDimesnions.actionButtonWidth),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
