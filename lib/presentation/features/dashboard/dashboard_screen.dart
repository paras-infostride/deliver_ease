

import 'package:deliver_ease/core/utils/connectivity_wrapper.dart';
import 'package:deliver_ease/presentation/common_components/common_components.dart';
import 'package:deliver_ease/presentation/common_components/complete_profile_view.dart';
import 'package:deliver_ease/presentation/common_components/text_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

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
    DashboardScreenState  dashboardScreenStateNotifier = ref.watch(dashboardScreenControllerProvider);

    return Scaffold(
      body: Center(
        child: ConnectivityWrapper(
          child: Builder(builder: (context)
          {
            if (dashboardScreenStateNotifier.showLoader) {
              return const CircularProgressIndicator();
            } else if (dashboardScreenStateNotifier.hasMessage.isNotEmpty) {
              return Text(dashboardScreenStateNotifier.hasMessage);

            } else if (dashboardScreenStateNotifier.userProfile?.name == null) {
                   return const CompleteProfileView();
                  }


            else if (dashboardScreenStateNotifier.userProfile?.isVerified == null || dashboardScreenStateNotifier.userProfile?.isVerified == false ) {
                   return const NoVerifiedView();
                  }
            else {
              return TextView(title: dashboardScreenStateNotifier.userProfile.toString(),
              maxLine: 30,);
            }
          })
        ),
      ),
    );
  }
}
