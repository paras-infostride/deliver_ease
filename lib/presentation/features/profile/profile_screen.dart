import 'dart:io';

import 'package:deliver_ease/core/routes/app_routes_name.dart';
import 'package:deliver_ease/core/utils/app_date_picker.dart';
import 'package:deliver_ease/core/utils/app_strings.dart';
import 'package:deliver_ease/core/utils/connectivity_wrapper.dart';
import 'package:deliver_ease/core/utils/utils.dart';
import 'package:deliver_ease/domain/user_profile/user_profile.dart';
import 'package:deliver_ease/presentation/common_components/common_components.dart';
import 'package:deliver_ease/presentation/features/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common_components/dialog/info_dialog.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  final UserProfile? userProfile;

  const ProfileScreen({super.key, required this.userProfile});

  @override
  ConsumerState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late final TextEditingController _textEditingControllerName;
  late final TextEditingController _textEditingControllerLastName;
  late final TextEditingController _textEditingControllerEmailAddress;
  late final TextEditingController _textEditingControllerAddress;
  late final TextEditingController _textEditingControllerGender;
  late final TextEditingController _textEditingControllerIsServiceProvider;
  late final TextEditingController _textEditingControllerDateOFBirth;
  late final TextEditingController _textEditingControllerVehicleType;
  late final TextEditingController _textEditingControllerVehicleNumber;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _textEditingControllerName = TextEditingController();
    _textEditingControllerLastName = TextEditingController();
    _textEditingControllerEmailAddress = TextEditingController();
    _textEditingControllerAddress = TextEditingController();
    _textEditingControllerGender = TextEditingController();
    _textEditingControllerDateOFBirth = TextEditingController();
    _textEditingControllerVehicleType = TextEditingController();
    _textEditingControllerVehicleNumber = TextEditingController();
    // _textEditingControllerIsServiceProvider = TextEditingController();


    if (widget.userProfile != null) {
      _textEditingControllerName.text = widget.userProfile?.name ?? '';
      _textEditingControllerLastName.text = widget.userProfile?.lastName ?? '';
      _textEditingControllerEmailAddress.text =
          widget.userProfile?.emailAddress ?? '';
      _textEditingControllerDateOFBirth.text =
          widget.userProfile?.dateOfBirth ?? '';
      _textEditingControllerGender.text = widget.userProfile?.gender ?? 'Male';
      selectedVehicleType = widget.userProfile?.vehicleType ?? 'Bike';

      _textEditingControllerVehicleNumber.text =
          widget.userProfile?.vehicleNumber ?? '';

      selectedIsUSerServiceProvider = widget.userProfile?.isServiceProvider ?? false;
      // _textEditingControllerIsServiceProvider.text =
      //     widget.userProfile?.isServiceProvider.toString() ?? false.toString();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref.read(profileControllerProvider.notifier).setUserServiceProvider(
      //     widget.userProfile?.isServiceProvider ?? false);
    });

  }

  @override
  void dispose() {
    _textEditingControllerName.dispose();
    _textEditingControllerLastName.dispose();
    _textEditingControllerEmailAddress.dispose();
    _textEditingControllerAddress.dispose();
    _textEditingControllerGender.dispose();
    _textEditingControllerDateOFBirth.dispose();
    _textEditingControllerVehicleType.dispose();
    _textEditingControllerVehicleNumber.dispose();
    // _textEditingControllerIsServiceProvider.dispose();
    super.dispose();
  }

  final List<String> listOfGender = const ["Male", "Female", "Others"];
  final List<String> serviceProviderList = const ["Yes", "No"];
  final List<String> vehicleList = const ["Bike", "Van", "Mini trucks"];
  String selectedVehicleType = "Bike";
  bool selectedIsUSerServiceProvider = false;


  @override
  Widget build(BuildContext context) {
    ProfileScreenState profileNotifier = ref.watch(profileControllerProvider);
    ref.listen<ProfileScreenState>(profileControllerProvider, (prev, next) {
      if (prev != next && stringHasValue(next.hasMessage)) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return InfoDialogViewGet(
              message: next.hasMessage,
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          },
        );
      }
      if (prev != next &&
          next.apiTriggredMessage == AppStrings.deleteProfileSuccessfully &&
          next.showLoader == false) {
        context.goNamed(AppRoutesName.loginScreen);
      } else if (prev != next &&
          next.apiTriggredMessage == AppStrings.profileUpdateSuccessfully &&
          next.showLoader == false) {
        context.goNamed(AppRoutesName.dashboardScreen);
      }
    });

    debuggerAdvance(
        tag: "Selected Service provider",
        value: serviceProviderList
            .indexOf(profileNotifier.isUSerServiceProvider ? "Yes" : "No"));

    return Scaffold(
      appBar: customAppBar(
          title: "Profile",
          onBackPressed: () {
            context.goNamed(AppRoutesName.dashboardScreen);
          }),
      body: SafeArea(
          child: Center(
        child: ConnectivityWrapper(
            child: profileNotifier.showLoader
                ? const CircularProgressIndicator()
                : SingleChildScrollView(
                    child: Column(
                      children: [

                        // Image View
                        Container(
                          width: double.infinity,
                          height: Responsive.setHeightByPercentage(25),
                          alignment: Alignment.center,
                          child: Builder(builder: (context) {
                            if (stringHasValue(
                                widget.userProfile?.profileUrl)) {
                              return Image.network(
                                widget.userProfile!.profileUrl!,
                                height: Responsive.setWidth(120),
                                width: Responsive.setWidth(120),
                                fit: BoxFit.fill,
                              );
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  /*        showDialog(
                               context: context,
                               barrierDismissible: true,
                               builder: (BuildContext context) {
                              return ImagePickerDialog(
                                onPressedOnCamera: () async {
                                  XFile? pickedFile = await  ImagePickerUtil.pickImage(ImageSource.camera);
                                   if(pickedFile != null)
                                     {
                                       ref.read(profileControllerProvider.notifier).updateImage(pickedFile: pickedFile);

                                     }
                                },
                                onPressedOnGallery: () async{
                                  XFile? pickedFile = await  ImagePickerUtil.pickImage(ImageSource.gallery);
                                  if(pickedFile != null)
                                  {
                                    ref.read(profileControllerProvider.notifier).updateImage(pickedFile: pickedFile);

                                  }
                                },
                              );
                               },
                             );*/
                                },
                                child: Builder(builder: (context) {
                                  if (profileNotifier.pickedFile == null) {
                                    return Image.asset(
                                      "assets/user_profile_grey.png",
                                      height: Responsive.setWidth(120),
                                      width: Responsive.setWidth(120),
                                      fit: BoxFit.fill,
                                    );
                                  } else {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      // clipBehavior: Cli,
                                      child: Image.file(
                                        File(profileNotifier.pickedFile!.path),
                                        height: Responsive.setWidth(120),
                                        width: Responsive.setWidth(120),
                                        fit: BoxFit.fill,
                                      ),
                                    );
                                  }
                                }),
                              );
                            }
                          }),
                        ),
                        const Divider(),

                        // Form view
                        Form(
                            key: _formKey,
                            child: Center(
                              child: SizedBox(
                                width: Responsive.setWidthByPercentage(80),
                                child: Column(
                                  children: [
                                    // First Name
                                    AppTextField(
                                      context: context,
                                      onChanged: (String value) {},
                                      headingText: "First name",
                                      margin: const EdgeInsets.only(top: 20),
                                      controller: _textEditingControllerName,
                                      maxLimit: 100,
                                      validator: Validator.validateEmpty,
                                      hint: "first name",
                                    ),

                                    //Last Name
                                    AppTextField(
                                      context: context,
                                      onChanged: (String value) {},
                                      headingText: "Last name",
                                      margin: const EdgeInsets.only(top: 20),
                                      controller:
                                          _textEditingControllerLastName,
                                      maxLimit: 100,
                                      hint: "last name",
                                    ),

                                    // Email Address
                                    AppTextField(
                                      context: context,
                                      keyboard: TextInputType.emailAddress,
                                      onChanged: (String value) {},
                                      headingText: "Email address",
                                      margin: const EdgeInsets.only(top: 20),
                                      controller:
                                          _textEditingControllerEmailAddress,
                                      maxLimit: 100,
                                      hint: "example@gmail.com",
                                    ),

                                    // Address
                                    /*   AppTextField(
                              readOnly: true,
                              onTap: ()
                              {
                                 context.goNamed(AppRoutesName.googleMApAddressPicker,
                                   extra: {
                                     'userProfile': widget.userProfile,
                                   },);
                              },
                              context: context,
                              onChanged: (String value) {},
                              headingText: "Address",
                              margin: const EdgeInsets.only(top: 20),
                              controller: _textEditingControllerAddress,
                              validator: Validator.validateEmpty,
                              maxLimit: 100,
                              hint: "26985 Brighton Lane, Lake Forest, CA 92630",
                            ), */
                                    // Address

                                    // Date of birth

                                    AppTextField(
                                      readOnly: true,
                                      context: context,
                                      onChanged: (String value) {},
                                      onTap: () async {
                                        await appDatePicker(
                                            context: context,
                                            onDateSelect: (DateTime dateTime) {
                                              debuggerAdvance(
                                                  tag: "selected date is ",
                                                  value: DateFormatters
                                                      .formatterddMMYYYY
                                                      .format(dateTime));
                                              _textEditingControllerDateOFBirth
                                                      .text =
                                                  DateFormatters
                                                      .formatterddMMYYYY
                                                      .format(dateTime);
                                            },
                                            isLastDateIsCurrentDay: true,
                                            selectedDate: DateTime.now());
                                      },
                                      headingText: "Date of birth",
                                      margin: const EdgeInsets.only(top: 20),
                                      controller:
                                          _textEditingControllerDateOFBirth,
                                      hint: "Select date of birth",
                                    ),

                                    //Gender
                                    CustomDropdown(
                                      padding: const EdgeInsets.only(left: 20),
                                      initialText: "Select gender",
                                      margin: const EdgeInsets.only(top: 20),
                                      headingText: "Gender",
                                      items: listOfGender,
                                      onChanged: (value) {
                                        _textEditingControllerGender.text =
                                            value;
                                      },
                                      onInit: (value) {},
                                      isExpanded: true,
                                      selectedValueIndex: listOfGender.indexOf(
                                          _textEditingControllerGender.text),
                                    ), //Gender

                                    // is Service Provider

                                    CustomDropdown(
                                      margin: const EdgeInsets.only(top: 20),
                                      headingText: "is Service provider",
                                      items: serviceProviderList,
                                      onChanged: (value) {

                                        debuggerAdvance(
                                            tag: "on select user provider",
                                            value: value);

                                        selectedIsUSerServiceProvider = value == "Yes" ? true : false;
                                        selectedVehicleType = "Bike";
                                        setState(() {});
                                        // ref
                                        //     .read(profileControllerProvider
                                        //         .notifier)
                                        //     .setUserServiceProvider(
                                        //         value == "Yes" ? true : false);
                                      },
                                      onInit: (value) {},
                                      isExpanded: true,
                                      selectedValueIndex: serviceProviderList
                                          .indexOf(selectedIsUSerServiceProvider
                                              ? "Yes"
                                              : "No"),
                                    ),

                                    // Vehicle type

                                    Visibility(
                                      visible:
                                      selectedIsUSerServiceProvider,
                                      child: CustomDropdown(
                                        margin: const EdgeInsets.only(top: 20),
                                        headingText: "Vehicle type",
                                        items: vehicleList,
                                        onChanged: (value) {
                                          selectedVehicleType = value;
                                        },
                                        onInit: (value) {},
                                        isExpanded: true,
                                        selectedValueIndex: vehicleList
                                            .indexOf(selectedVehicleType),
                                      ),
                                    ),

                                    // Vehicle number
                                    Visibility(
                                      visible:
                                      selectedIsUSerServiceProvider,
                                      child: AppTextField(
                                        context: context,
                                        onChanged: (String value) {},
                                        headingText: "Vehicle number",
                                        margin: const EdgeInsets.only(top: 20),
                                        controller:
                                            _textEditingControllerVehicleNumber,
                                        validator: Validator.validateEmpty,
                                        maxLimit: 13,
                                        hint: "PB 65 AQ 7085",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),

                        profileNotifier.showLoader
                            ? const CircularProgressIndicator()
                            : AppButton(
                                title: "Save",
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    UserProfile userProfileReqModel =
                                        UserProfile(
                                      isVerified:
                                          widget.userProfile?.isVerified,
                                      name: _textEditingControllerName.text,
                                      userId: widget.userProfile?.userId,
                                      phoneNumber:
                                          widget.userProfile?.phoneNumber,
                                      address:
                                          _textEditingControllerAddress.text,
                                      dateOfBirth:
                                          _textEditingControllerDateOFBirth
                                              .text,
                                      emailAddress:
                                          _textEditingControllerEmailAddress
                                              .text,
                                      gender: _textEditingControllerGender.text,
                                      isServiceProvider: ref
                                          .read(profileControllerProvider)
                                          .isUSerServiceProvider,
                                      isServiceProviderActive: widget
                                          .userProfile?.isServiceProviderActive,
                                      lastName:
                                          _textEditingControllerLastName.text,
                                      vehicleNumber:
                                          _textEditingControllerVehicleNumber
                                              .text,
                                      vehicleType: selectedVehicleType,
                                    );

                                    ref
                                        .read(
                                            profileControllerProvider.notifier)
                                        .updateProfile(userProfileReqModel);
                                  }
                                },
                                width: Responsive.setWidthByPercentage(80),
                                margin: const EdgeInsets.only(top: 40),
                              ),

                        /// Delete profile
                        TextView(
                          title: "Delete Profile",
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          textColor: Colors.red,
                          margin: EdgeInsets.only(
                              bottom: Responsive.setHeightByPercentage(5),
                              top: Responsive.setHeightByPercentage(7)),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          onPressed: () {
                            ref
                                .read(profileControllerProvider.notifier)
                                .deleteProfile();
                          },
                        )
                      ],
                    ),
                  )),
      )),
    );
  }
}
