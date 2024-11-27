import 'package:deliver_ease/core/utils/connectivity_wrapper.dart';
import 'package:deliver_ease/core/utils/image_picker.dart';
import 'package:deliver_ease/core/utils/utils.dart';
import 'package:deliver_ease/domain/user_profile/user_profile.dart';
import 'package:deliver_ease/presentation/common_components/common_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common_components/dialog/info_dialog.dart';


class ProfileScreen extends ConsumerStatefulWidget {
  final UserProfile userProfile;
  const ProfileScreen({super.key,
    required this.userProfile});

  @override
  ConsumerState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {

  @override
  void initState() {
    super.initState();
    debuggerAdvance(
      tag: "init profile",
      value: widget.userProfile.phoneNumber
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Profile"),
      body: SafeArea(
        child:  Center(
          child: ConnectivityWrapper(
              child:
           Column(
             children: [
               Container(

               width: double.infinity,
               height: Responsive.setHeightByPercentage(30),
               alignment: Alignment.center,
                 child: Builder(builder: (context){
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
                              onPressedOnCamera: () {

                              },
                              onPressedOnGallery: () {

                              },
                            );
                             },
                           );
                         },
                         child: Image.asset("assets/user_profile_grey.png",
                           height: Responsive.setWidth(120),
                           width: Responsive.setWidth(120),
                           fit: BoxFit.fill,
                         ),
                       );
                     }
                 }),


               ),
               const Divider(
                 color: Colors.black,
               ),

             ],
           ),
          ),
        )

      ),
    );
  }
}
