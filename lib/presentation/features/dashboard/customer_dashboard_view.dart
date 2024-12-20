import 'package:deliver_ease/core/utils/responsive_util.dart';
import 'package:deliver_ease/presentation/common_components/app_text_fields.dart';
import 'package:deliver_ease/presentation/common_components/google_map_marker_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controllers/customer_dashboard_controller.dart';

class CustomerDashboardView extends ConsumerStatefulWidget {
  const CustomerDashboardView({super.key});

  @override
  ConsumerState createState() => _CustomerDashboardViewState();
}

class _CustomerDashboardViewState extends ConsumerState<CustomerDashboardView> {


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_)
    {
      ref.read(customerDashboardProvider.notifier).getInitialData();

      // Scaffold.of(context).showBottomSheet(
      //   enableDrag: true,
      //   showDragHandle: true,
      //   clipBehavior: Clip.antiAliasWithSaveLayer,
      //   shape:  const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(50),
      //       topRight: Radius.circular(50),
      //     ),
      //   ),
      //   constraints: BoxConstraints(
      //         minHeight: Responsive.setHeightByPercentage(55),
      //         maxHeight: Responsive.setHeightByPercentage(100)
      //       ),
      //       (BuildContext context ) {
      //
      //     return Container(
      //       height: Responsive.setHeightByPercentage(55),
      //       // decoration: const BoxDecoration(
      //       //   borderRadius: BorderRadius.only(
      //       //     topLeft: Radius.circular(20),
      //       //     topRight: Radius.circular(20),
      //       //   )
      //       // ),
      //
      //       child: const Center(
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           mainAxisSize: MainAxisSize.min,
      //           children: <Widget>[
      //             Text('Hello from Persistent Bottom Sheet'),
      //
      //           ],
      //         ),
      //       ),
      //     );
      //   },
      // );
    });

  }

  @override
  Widget build(BuildContext context) {
    CustomerDashboardState customerDashboardState = ref.watch(customerDashboardProvider);


    return Builder(
      builder: (context) {

        if (customerDashboardState.showLoader) {
          return const Center(child: CircularProgressIndicator());
        }
        else if (customerDashboardState.hasMessage.isNotEmpty) {
          return Center(child: Text(customerDashboardState.hasMessage));
        }
        else
          {
            return Stack(
              children: [
                const GoogleMapMarkerView(),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: DraggableScrollableSheet(
                    initialChildSize: 0.55,
                    maxChildSize: 1.0,
                    minChildSize: 0.3,
                    snap: true,
                    builder: (BuildContext context, myscrollController) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                            borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6)
                          )
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                           children: [

                             AppTextField(context: context, onChanged: (String? value)
                             {},
                             width: Responsive.setWidthByPercentage(80),
                               margin: const EdgeInsets.only(top: 30),
                               hint: "Where are you going?",
                               suffixIcon: Icon(Icons.search ,color: Colors.black,),


                             )
                           ],
                        ),
                      );
                    },
                  ),
                ),

              ],
            );
          }


      }
    );
  }
}
