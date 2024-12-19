import 'package:deliver_ease/core/utils/responsive_util.dart';
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
    });

  }

  @override
  Widget build(BuildContext context) {
    CustomerDashboardState customerDashboardState = ref.watch(customerDashboardProvider);
    return Builder(
      builder: (context) {

        if (customerDashboardState.showLoader) {
          return const Center(child: CircularProgressIndicator());
        } else if (customerDashboardState.hasMessage.isNotEmpty) {
          return Center(child: Text(customerDashboardState.hasMessage));
        }
        else
          {
            return Column(
              children: [

                SizedBox(
                    width: double.infinity,
                    height: Responsive.setHeightByPercentage(45),
                    child: GoogleMapMarkerView()),
              ],
            );
          }


      }
    );
  }
}
