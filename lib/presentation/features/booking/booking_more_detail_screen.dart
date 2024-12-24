import 'package:deliver_ease/core/utils/responsive_util.dart';
import 'package:deliver_ease/core/utils/validator.dart';
import 'package:deliver_ease/domain/user_profile/user_profile.dart';
import 'package:deliver_ease/presentation/common_components/common_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class BookingMoreDetailScreen extends ConsumerStatefulWidget {
  final UserProfile userProfile;

  const BookingMoreDetailScreen({super.key, required this.userProfile});

  @override
  ConsumerState createState() => _BookingMoreDetailScreenState();

}

class _BookingMoreDetailScreenState extends ConsumerState<BookingMoreDetailScreen> {

  late final TextEditingController _textEditingControllerSenderName;
  late final TextEditingController _textEditingControllerSenderPhoneNumber;
  late final TextEditingController _textEditingControllerSenderAddress;
  late final TextEditingController _textEditingControllerSenderLandmark;

  late final TextEditingController _textEditingControllerReceiverName;
  late final TextEditingController _textEditingControllerReceiverPhoneNumber;
  late final TextEditingController _textEditingControllerReceiverAddress;
  late final TextEditingController _textEditingControllerReceiverLandmark;


  @override
  void initState() {
    super.initState();

    _textEditingControllerSenderName = TextEditingController();
    _textEditingControllerSenderPhoneNumber = TextEditingController();
    _textEditingControllerSenderAddress = TextEditingController();
    _textEditingControllerSenderLandmark = TextEditingController();

    _textEditingControllerReceiverName = TextEditingController();
    _textEditingControllerReceiverPhoneNumber = TextEditingController();
    _textEditingControllerReceiverAddress = TextEditingController();
    _textEditingControllerReceiverLandmark = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingControllerSenderName.dispose();
    _textEditingControllerSenderPhoneNumber.dispose();
    _textEditingControllerSenderAddress.dispose();
    _textEditingControllerSenderLandmark.dispose();

    _textEditingControllerReceiverName.dispose();
    _textEditingControllerReceiverPhoneNumber.dispose();
    _textEditingControllerReceiverAddress.dispose();
    _textEditingControllerReceiverLandmark.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "More details"),
      body:  Align(
        alignment: Alignment.center,

        child: SizedBox(
          width: Responsive.setWidthByPercentage(90),
          child:   SingleChildScrollView(
            child: Column(
              children: [

              const TextView(
                title: "Enter Pickup detail",
                fontSize: 24,
                fontWeight: FontWeight.w600,
                width: double.infinity,
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 20,bottom: 20),
             ),

                Form(
                child: Column(
                  children: [

                    AppTextField(
                      context: context,
                      onChanged: (String value) {},
                      headingText: "Sender name",
                      margin: const EdgeInsets.only(top: 20),
                      controller: _textEditingControllerSenderName,
                      maxLimit: 100,
                      validator: Validator.validateEmpty,
                      hint: "name",
                    ),
                    AppTextField(
                      context: context,
                      onChanged: (String value) {},
                      headingText: "Sender address",
                      margin: const EdgeInsets.only(top: 20),
                      controller: _textEditingControllerSenderAddress,
                      maxLimit: 100,
                      validator: Validator.validateEmpty,
                      hint: "address",
                    ),
                    AppTextField(
                      context: context,
                      onChanged: (String value) {},
                      headingText: "Sender Landmark",
                      margin: const EdgeInsets.only(top: 20),
                      controller: _textEditingControllerSenderLandmark,
                      maxLimit: 100,
                      validator: Validator.validateEmpty,
                      hint: "landmark",
                    ),
                    const TextView(
                      title: "Enter Drop detail",
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      width: double.infinity,
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 20,bottom: 20),
                    ),
                    AppTextField(
                      context: context,
                      onChanged: (String value) {},
                      headingText: "Receiver name",
                      margin: const EdgeInsets.only(top: 20),
                      controller: _textEditingControllerReceiverName,
                      maxLimit: 100,
                      validator: Validator.validateEmpty,
                      hint: "name",
                    ),
                    AppTextField(
                      context: context,
                      onChanged: (String value) {},
                      headingText: "Receiver address",
                      margin: const EdgeInsets.only(top: 20),
                      controller: _textEditingControllerReceiverAddress,
                      maxLimit: 100,
                      validator: Validator.validateEmpty,
                      hint: "address",
                    ),
                    AppTextField(
                      context: context,
                      onChanged: (String value) {},
                      headingText: "Receiver Landmark",
                      margin: const EdgeInsets.only(top: 20),
                    controller: _textEditingControllerReceiverLandmark,
                      maxLimit: 100,
                      validator: Validator.validateEmpty,
                      hint: "landmark",
                    ),

                    AppButton(
                        title: "Book",
                        onPressed: ()
                    {

                    },
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    ),

                  ],
                )
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
