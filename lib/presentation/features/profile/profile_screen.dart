import 'dart:io';

import 'package:deliver_ease/core/utils/connectivity_wrapper.dart';
import 'package:deliver_ease/core/utils/image_picker.dart';
import 'package:deliver_ease/core/utils/utils.dart';
import 'package:deliver_ease/domain/user_profile/user_profile.dart';
import 'package:deliver_ease/presentation/common_components/common_components.dart';
import 'package:deliver_ease/presentation/features/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common_components/dialog/info_dialog.dart';
import 'package:image_picker/image_picker.dart';



class ProfileScreen extends ConsumerStatefulWidget {
  final UserProfile userProfile;
  const ProfileScreen({super.key,
    required this.userProfile});

  @override
  ConsumerState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {


  late final TextEditingController _textEditingControllerName;
  late final TextEditingController _textEditingControllerLastName;

  late final TextEditingController _textEditingControllerEmailAddress;
  late final TextEditingController _textEditingControllerAddress;
  late final TextEditingController _textEditingControllerGender;
  late final TextEditingController _textEditingControllerDateOFBirth;
  late final TextEditingController _textEditingControllerVehicleType;
  late final TextEditingController _textEditingControllerVehicleNumber;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _textEditingControllerName = TextEditingController();
    _textEditingControllerLastName= TextEditingController();
    _textEditingControllerEmailAddress= TextEditingController();
    _textEditingControllerAddress= TextEditingController();
    _textEditingControllerGender= TextEditingController();
    _textEditingControllerDateOFBirth= TextEditingController();
    _textEditingControllerVehicleType= TextEditingController();
    _textEditingControllerVehicleNumber= TextEditingController();
  }

  @override
  void dispose() {
    _textEditingControllerName .dispose();
    _textEditingControllerLastName.dispose();
    _textEditingControllerEmailAddress.dispose();
    _textEditingControllerAddress.dispose();
    _textEditingControllerGender.dispose();
    _textEditingControllerDateOFBirth.dispose();
    _textEditingControllerVehicleType.dispose();
    _textEditingControllerVehicleNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProfileScreenState profileNotifier = ref.watch(profileControllerProvider);
    return Scaffold(
      appBar: customAppBar(title: "Profile"),
      body: SafeArea(
        child:  Center(
          child: ConnectivityWrapper(
              child:
           SingleChildScrollView(
             child: Column(
               children: [

                 // Image View
                 Container(
                 width: double.infinity,
                 height: Responsive.setHeightByPercentage(30),
                 alignment: Alignment.center,
                   child: Builder(builder: (context) {

                     if(stringHasValue(widget.userProfile.profileUrl))
                       {
                         return Image.network(widget.userProfile.profileUrl!,
                         height: Responsive.setWidth(120),
                         width: Responsive.setWidth(120),
                           fit: BoxFit.fill,
                         );
                       }
                     else
                       {
                         return GestureDetector(
                           onTap: ()
                           {
                             showDialog(
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
                             );
                           },
                           child: Builder(builder: (context)
                           {
                             if(profileNotifier.pickedFile == null)
                               {
                                 return Image.asset("assets/user_profile_grey.png",
                                   height: Responsive.setWidth(120),
                                   width: Responsive.setWidth(120),
                                   fit: BoxFit.fill,
                                 );
                               }
                             else
                               {
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
                 const Divider(
                 ),

                 // Form view
                 Form(
                   key: _formKey,
                     child: Center(
                       child: SizedBox(
                         width: Responsive.setWidthByPercentage(80),
                         child: Column(
                          children: [
                        // First Name
                         AppTextField(context: context, onChanged: (String value )
                           {

                         },
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
                          controller: _textEditingControllerLastName,
                          maxLimit: 100,
                          hint: "last name",
                        ),
                        // Email Address
                        AppTextField(
                          context: context,
                          onChanged: (String value) {},
                          headingText: "Email address",
                          margin: const EdgeInsets.only(top: 20),
                          controller: _textEditingControllerEmailAddress,
                          maxLimit: 100,
                          hint: "example@gmail.com",
                          validator: Validator.validateEmail,
                        ),
                        // Address
                        AppTextField(
                          context: context,
                          onChanged: (String value) {},
                          headingText: "Address",
                          margin: const EdgeInsets.only(top: 20),
                          controller: _textEditingControllerAddress,
                          validator: Validator.validateEmpty,
                          maxLimit: 100,
                          hint: "26985 Brighton Lane, Lake Forest, CA 92630",
                        ),  // Address
                        // Phone Number
                        AppTextField(
                          context: context,
                          onChanged: (String value) {},
                          headingText: "Phone number",
                          margin: const EdgeInsets.only(top: 20),
                          controller: _textEditingControllerAddress,
                          validator: Validator.validateMobileNo,
                          maxLimit: 13,
                          hint: "+91987654321",
                        ),
                        // Phone Number
                        AppTextField(
                          context: context,
                          onChanged: (String value) {},
                          headingText: "Phone number",
                          margin: const EdgeInsets.only(top: 20),
                          controller: _textEditingControllerAddress,
                          validator: Validator.validateMobileNo,
                          maxLimit: 13,
                          hint: "+91987654321",
                        ),

                            //Gender
                            CustomDropdown(

                              padding: EdgeInsets.only(left: 20),
                              initialText: "Select gender",
                              margin: const EdgeInsets.only(top: 20),
                              headingText: "Gender",
                              items: const ["Male", "Female","Others"],
                              onChanged: (value) {

                              },
                              onInit: (value) {

                              },
                              isExpanded: true,
                            ),   //Gender

                            // is Service Provider
                            CustomDropdown(
                              padding: const EdgeInsets.only(left: 20),
                              margin: const EdgeInsets.only(top: 20),
                              headingText: "is Service provider",
                              items: const ["Yes", "No"],
                              onChanged: (value) {

                              },
                              onInit: (value) {

                              },
                              isExpanded: true,
                              selectedValueIndex: 1,
                            ),



                          ],
                                        ),
                       ),
                     )
                 ),

                 AppButton(
                  title: "Save",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  width: Responsive.setWidthByPercentage(80),
                  margin: const EdgeInsets.only(top: 40),
                ),

              ],
             ),
           ),
          ),
        )

      ),
    );
  }
}
