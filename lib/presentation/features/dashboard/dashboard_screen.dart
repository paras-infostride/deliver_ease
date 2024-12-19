

import 'package:deliver_ease/core/utils/app_strings.dart';
import 'package:deliver_ease/core/utils/connectivity_wrapper.dart';
import 'package:deliver_ease/core/utils/list_utility.dart';
import 'package:deliver_ease/presentation/common_components/common_components.dart';
import 'package:deliver_ease/presentation/common_components/complete_profile_view.dart';
import 'package:deliver_ease/presentation/common_components/dialog/info_dialog.dart';
import 'package:deliver_ease/presentation/common_components/text_view.dart';
import 'package:deliver_ease/presentation/features/dashboard/service_provider_dashboard_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routes/app_routes_name.dart';
import 'customer_dashboard_view.dart';
import 'dashboard_controller.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_)
    {
      ref.read(dashboardScreenControllerProvider.notifier).getData();
    });

  }


  @override
  Widget build(BuildContext context) {

    DashboardScreenState dashboardScreenStateNotifier = ref.watch(dashboardScreenControllerProvider);

    ref.listen<DashboardScreenState>(dashboardScreenControllerProvider, ( prev, next) {

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

      if(prev != next  && next.apiResponseSuccess == AppStrings.logoutSuccessfully && next.showLoader == false)
      {
        context.goNamed(AppRoutesName.loginScreen);
      }

    });

    return Scaffold(
      appBar: customAppBar(title: "DeliverEase",
      hasArrow: false,
      actions: [

        if(stringHasValue(dashboardScreenStateNotifier.userProfile?.name)
        )...{
          IconButton(onPressed: ()
          {
            context.goNamed(AppRoutesName.profileScreen,
              extra: {
                'userProfile': dashboardScreenStateNotifier.userProfile,
              },);
            // ref.read(dashboardScreenControllerProvider.notifier).logOut();
          },
              icon: const Icon(Icons.account_circle , color:  Colors.white,)),
        },
        IconButton(onPressed: ()
            {
              ref.read(dashboardScreenControllerProvider.notifier).logOut();
            }, icon: const Icon(Icons.logout , color:  Colors.white,))
      ]
      ),
      body: Center(
        child: ConnectivityWrapper(
          child: Builder(builder: (context)
          {
            if (dashboardScreenStateNotifier.showLoader) {
              return const CircularProgressIndicator();
            } else if (dashboardScreenStateNotifier.hasMessage.isNotEmpty) {
              return Text(dashboardScreenStateNotifier.hasMessage);

            } else if (dashboardScreenStateNotifier.userProfile?.name == null) {
                   return  CompleteProfileView(
                     onTap: ()
                     {
                       context.goNamed(AppRoutesName.profileScreen ,
                         extra: {
                           'userProfile': dashboardScreenStateNotifier.userProfile,
                         },
                       );
                     },
                   );
                  }
            else if (dashboardScreenStateNotifier.userProfile?.isVerified == null || dashboardScreenStateNotifier.userProfile?.isVerified == false ) {
                   return const NoVerifiedView();
                  }
            else if(dashboardScreenStateNotifier.userProfile?.isServiceProvider ?? false ){

              return  const ServiceProviderDashboardView();
            } else
              {
                return const CustomerDashboardView();
              }
          })
        ),
      ),
    );
  }
}
