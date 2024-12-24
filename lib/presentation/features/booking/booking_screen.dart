import 'dart:async';

import 'package:deliver_ease/core/utils/app_strings.dart';
import 'package:deliver_ease/core/utils/list_utility.dart';
import 'package:deliver_ease/core/utils/responsive_util.dart';
import 'package:deliver_ease/domain/booking/booking_model.dart';
import 'package:deliver_ease/domain/goole_places/google_places_res_model.dart';
import 'package:deliver_ease/domain/user_profile/user_profile.dart';
import 'package:deliver_ease/presentation/common_components/common_components.dart';
import 'package:deliver_ease/presentation/features/booking/controller/booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routes/app_routes_name.dart';
import '../../common_components/dialog/info_dialog.dart';

class BookingScreen extends ConsumerStatefulWidget {
  final UserProfile userProfile;

  const BookingScreen({super.key, required this.userProfile});

  @override
  ConsumerState createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {

 late final  TextEditingController _textEditingControllerPickUp;
 late final  TextEditingController _textEditingControllerDrop;


  @override
  void initState() {
    super.initState();
    _textEditingControllerPickUp = TextEditingController();
    _textEditingControllerDrop = TextEditingController();
    WidgetsBinding.instance
        .addPostFrameCallback((_)
    {
      ref.read(bookingControllerProvider.notifier).getCurrentLocation();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingControllerPickUp.dispose();
    _textEditingControllerDrop.dispose();
    _debounce?.cancel();
  }

 Timer? _debounce;

 List<String> listOfPackageType = ["Food" , 'Medicines', 'Groceries', 'Documents' , 'Electronics' , 'Clothes' ,'Others'];
 late  String selectedPackageType = "Food";


 @override
  Widget build(BuildContext context) {

    BookingScreenState bookingScreenState = ref.watch(bookingControllerProvider);

    ref.listen<BookingScreenState>(bookingControllerProvider, ( prev, next) {
      if (prev != next &&
          stringHasValue(next.pickupAddress) &&
          next.showLoader == false) {
        _textEditingControllerPickUp.text = next.pickupAddress;
      }
    });



    return Scaffold(
      appBar: customAppBar(title: "Booking",
      onBackPressed: ()
          {
            context.goNamed(AppRoutesName.dashboardScreen);
          }
      ),
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: Responsive.setWidthByPercentage(90),
          child: Center(
            child: Builder(
                builder: (context)
            {
                  if (bookingScreenState.showLoader) {
                    return const CircularProgressIndicator();
                  }
                  else if(stringHasValue(bookingScreenState.hasMessage)) {
                    return ErrorView(message: bookingScreenState.hasMessage);
                  }
                  else {
                    return Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         SizedBox(width: Responsive.setWidthByPercentage(100)),
                         AppTextField(
                          controller: _textEditingControllerPickUp,
                          context: context,
                          onChanged: (String? value) {
                            if (stringHasValue(value)) {
                              if (_debounce?.isActive ?? false)
                              {
                                _debounce?.cancel();
                              }
                              _debounce = Timer(const Duration(milliseconds: 500), () {
                                ref.read(bookingControllerProvider.notifier).getSearchedLocations(value: value!, isDropTextfieldActive: false);
                              });
                            }
                          },
                           onSubmitted: (String? value) {
                            if (stringHasValue(value)) {
                              if (_debounce?.isActive ?? false)
                              {
                                _debounce?.cancel();
                              }
                              _debounce = Timer(const Duration(milliseconds: 500), () {
                                ref.read(bookingControllerProvider.notifier).getSearchedLocations(value: value!, isDropTextfieldActive: false);
                              });
                            }
                          },
                          // width: Responsive.setWidthByPercentage(80),
                          margin: const EdgeInsets.only(top: 30),
                          suffixIcon: const Icon(Icons.search ,color: Colors.grey,),
                          headingText: "Pickup",
                        ),
                         AppTextField(
                          context: context,
                          controller: _textEditingControllerDrop,
                          onChanged: (String? value) {
                            if (stringHasValue(value)) {
                              if (_debounce?.isActive ?? false)
                                {
                                  _debounce?.cancel();
                                }
                              _debounce = Timer(const Duration(milliseconds: 500), () {
                                ref.read(bookingControllerProvider.notifier).getSearchedLocations(value: value!, isDropTextfieldActive: true);
                              });
                            }
                          },
                           onSubmitted: (String? value) {
                            if (stringHasValue(value)) {
                              if (_debounce?.isActive ?? false)
                                {
                                  _debounce?.cancel();
                                }
                              _debounce = Timer(const Duration(milliseconds: 500), () {
                                ref.read(bookingControllerProvider.notifier).getSearchedLocations(value: value!, isDropTextfieldActive: true);
                              });
                            }
                          },
                          // width: Responsive.setWidthByPercentage(80),
                          margin: const EdgeInsets.only(top: 30),
                          suffixIcon: const Icon(Icons.search ,color: Colors.grey,),
                          headingText: "Drop",
                          hint: "search drop address",
                        ),
                         Builder(
                             builder: (context)
                         {
                           if(bookingScreenState.showLoadingTextForPlacesSuggestion)
                             {
                               return  const TextView(title: "Loading....", margin: EdgeInsets.only(top: 6),);
                             }
                           else
                             {
                               return  ConstrainedBox(
                                 constraints: BoxConstraints(
                                     maxHeight: Responsive.setHeightByPercentage(25),
                                     maxWidth: Responsive.setWidthByPercentage(80)
                                 ),
                                 child: ListView.builder(
                                     keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                                     physics: const BouncingScrollPhysics(),
                                     itemCount: bookingScreenState.listOfPlaces.length,
                                     shrinkWrap: true,
                                     itemBuilder: (context, index) {
                                       Predictions prediction =
                                       bookingScreenState.listOfPlaces[index];
                                       return ListTile(
                                         onTap: ()
                                         {
                                           FocusScope.of(context).unfocus();
                                           BookingScreenState booingScreenState = ref.read(bookingControllerProvider);
                                           if(booingScreenState.dropTextfieldActive)
                                           {
                                             _textEditingControllerDrop.text = prediction.description!;
                                           }
                                           else
                                           {
                                             _textEditingControllerPickUp.text = prediction.description!;
                                           }


                                           ref.read(bookingControllerProvider.notifier).onTapOnAnyLocation();
                                         },
                                         title: TextView(
                                           fontSize: 14,
                                           title: prediction.description ?? '',
                                           maxLine: 2,
                                           overflow: TextOverflow.ellipsis,
                                         ),
                                       );
                                     }),
                               );
                             }
                         }),
                         CustomDropdown(
                          margin: const EdgeInsets.only(top: 20),
                          headingText: "Parcel Type",
                          items: listOfPackageType,
                          onChanged: (value) {
                            selectedPackageType = value;
                          },
                          onInit: (value) {},
                          isExpanded: true,
                          selectedValueIndex: listOfPackageType
                              .indexOf(selectedPackageType),
                        ),
                         const Spacer(
                          flex: 3,
                        ),
                         AppButton(title: "Proceed", onPressed: () {
                           BookingModel bookingModel = BookingModel();

                           // bookingModel.senderLat =
                          context.goNamed(AppRoutesName.bookingMoreDetailScreen,
                              extra: {
                               "userProfile" : widget.userProfile,
                               "bookingModel"   : bookingModel
                          });
                        }),
                         const Spacer(),

                      ],
                    ),
                  ),
                );
               }
            },

            ),
          )
        ),
      ),
    );
  }

}
