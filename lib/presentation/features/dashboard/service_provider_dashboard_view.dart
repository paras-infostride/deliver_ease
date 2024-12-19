import 'package:deliver_ease/core/utils/app_colors.dart';
import 'package:deliver_ease/core/utils/app_strings.dart';
import 'package:deliver_ease/core/utils/responsive_util.dart';
import 'package:deliver_ease/core/utils/utils.dart';
import 'package:deliver_ease/presentation/common_components/common_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'controllers/service_provider_dashboard_view_controller.dart';

import 'dashboard_controller.dart';

class ServiceProviderDashboardView extends ConsumerStatefulWidget {
  const ServiceProviderDashboardView({super.key});

  @override
  ConsumerState createState() => _ServiceProviderDashboardViewState();
}

class _ServiceProviderDashboardViewState extends ConsumerState<ServiceProviderDashboardView> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    ref.read(serviceProviderStateControllerProvider.notifier).getInitialStatusValue();
    });

  }


  @override
  Widget build(BuildContext context) {

    ServiceProviderViewState serviceProviderViewState = ref.watch(serviceProviderStateControllerProvider);

    ref.listen<ServiceProviderViewState>(serviceProviderStateControllerProvider, ( prev, next) {

      if(prev != next  && stringHasValue(next.hasMessage) &&  next.hasMessage == AppStrings.updatedStatusSuccessfully)
      {
        final scaffold = ScaffoldMessenger.of(context);
        scaffold.showSnackBar(
           SnackBar(
            content: TextView(title:  next.isUSerActive ? "Updated status to active": "Updated status to in-active",
              textColor:  Colors.white, alignment: Alignment.center,),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.primaryColor,
            margin: const EdgeInsets.all(20),
            shape: const StadiumBorder(),
          ),
        );

      }

    });


    return Column(
      children: [

        const SizedBox(
          height: 20,
        ),
        /// Set SerViceProvider is Ready to service
        SizedBox(
          width: Responsive.setWidthByPercentage(80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const TextView(title: "User active",
              margin: EdgeInsets.only(right: 20),
              ),
              CupertinoSwitch(
                value: serviceProviderViewState.isUSerActive,
                onChanged: (value) {
                 ref.read(serviceProviderStateControllerProvider.notifier).setSerViceProviderToActive(newValue: value);
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
