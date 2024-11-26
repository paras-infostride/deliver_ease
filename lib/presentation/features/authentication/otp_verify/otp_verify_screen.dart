import 'package:deliver_ease/core/routes/app_routes_name.dart';
import 'package:deliver_ease/core/utils/app_colors.dart';
import 'package:deliver_ease/core/utils/list_utility.dart';
import 'package:deliver_ease/core/utils/responsive_util.dart';
import 'package:deliver_ease/core/utils/app_dimesnions.dart';
import 'package:deliver_ease/core/utils/utils.dart';
import 'package:deliver_ease/presentation/common_components/app_button.dart';
import 'package:deliver_ease/presentation/common_components/custom_app_bar.dart';
import 'package:deliver_ease/presentation/common_components/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common_components/dialog/info_dialog.dart';
import 'package:pinput/pinput.dart';
import 'otp_verify_controller.dart';
import 'package:go_router/go_router.dart';


class OtpVerifyScreen extends ConsumerStatefulWidget {
  final String verificationID;
  const  OtpVerifyScreen ({super.key , required this.verificationID});

  @override
  ConsumerState createState() => _OtpVerifyScreenState();

}

class _OtpVerifyScreenState extends ConsumerState<OtpVerifyScreen> {

  late TextEditingController _textEditingController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle:  const TextStyle(fontSize: 20, color: AppColors.primaryColor, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  @override
  Widget build(BuildContext context) {

    OTPVerifyScreenState otpVerifyScreenState = ref.watch(otpVerifyControllerProvider);
    ref.listen<OTPVerifyScreenState>(otpVerifyControllerProvider, ( prev, next) {

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

      if(prev != next  && next.apiTriggerSuccess == true)
      {
        context.pushReplacementNamed(AppRoutesName.dashboardScreen);
      }

    });

    return Scaffold(
      appBar: customAppBar(
        title: "Verify screen",
      ),
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          // width: Responsive.setWidthByPercentage(80),
          child: SizedBox(
            width: Responsive.setWidthByPercentage(80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                 SizedBox(width: double.infinity,
                height: Responsive.setHeightByPercentage(20),
                ),

                  const TextView(title: "Enter the code sent to the number",
                   maxLine: 2,
                   fontSize: 18,
                   margin: EdgeInsets.only(bottom: 30),
                 ),

                 SizedBox(
                  width: Responsive.setWidthByPercentage(80),
                  child: Pinput(
                    forceErrorState: otpVerifyScreenState.showValidationText,
                    errorText:  otpVerifyScreenState.validationErrorText,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    length: 6,
                    controller: _textEditingController,
                    validator: (input) {
                      return input == null || input.trim().length != 5 ? null : 'Invalid pin';
                    },
                    onCompleted: (pin) => {
                      if (_textEditingController.text.length == 6) {

                      }
                    },
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),
                otpVerifyScreenState.showLoader  ? const CircularProgressIndicator() : AppButton(
                  title: "Verify",
                  onPressed: () {
                          ref
                              .read(otpVerifyControllerProvider.notifier)
                              .validateIt(
                                  verificationID: widget.verificationID,
                                  pin: _textEditingController.text);
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
        ),
      ),
    );
  }

}
