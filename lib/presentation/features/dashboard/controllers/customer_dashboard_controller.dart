import 'package:deliver_ease/core/global_providers.dart';
import 'package:deliver_ease/core/utils/debug_logger.dart';
import 'package:deliver_ease/core/utils/get_current_lat_long.dart';
import 'package:deliver_ease/domain/app_repo.dart';
import 'package:deliver_ease/domain/user_profile/user_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


final customerDashboardProvider = StateNotifierProvider.autoDispose<CustomerDashboardController, CustomerDashboardState>((ref) {
  AppRepo appRepo = ref.read(appRepoProvider);
  return CustomerDashboardController(
    appRepo: appRepo
  );
});


class CustomerDashboardController extends StateNotifier<CustomerDashboardState> {
  final AppRepo appRepo;
  CustomerDashboardController({required this.appRepo})
      : super(CustomerDashboardState(
          showLoader: false,
          hasMessage: "",
        ));

  getInitialData() async {
    try {
      state =
          state.copyWith(showLoader: true , hasMessage: '');
      Position position =   await  GetCurrentLatLongUtil.getCurrentPosition();
      List<UserProfile> listOfUserProfile = await appRepo.getListOfAllServiceProvider();
      debuggerAdvance(tag: "list of Service provider is ", value: listOfUserProfile.length);
      // List<HomeResItemModel> res = await ref.getContentForHomeScreen();
      // List<HomeResItemModel> res = await _repository.getContentForHomeScreen();

      state = state.copyWith(
        showLoader: false,
        latLng: LatLng(
            position.latitude,
            position.longitude)
      );
    }

    catch (e) {
      debuggerAdvance(tag: "At Catch Login Controller", value: e.runtimeType);
      state = state.copyWith(showLoader: false, hasMessage: e.toString());
    }
  }

}


class CustomerDashboardState {

  bool showLoader = false;
  String hasMessage = "";
  LatLng?  latLng;

//<editor-fold desc="Data Methods">
  CustomerDashboardState({
    required this.showLoader,
    required this.hasMessage,
    this.latLng,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerDashboardState &&
          runtimeType == other.runtimeType &&
          showLoader == other.showLoader &&
          hasMessage == other.hasMessage &&
          latLng == other.latLng);

  @override
  int get hashCode =>
      showLoader.hashCode ^ hasMessage.hashCode ^ latLng.hashCode;

  @override
  String toString() {
    return 'CustomerDashboardState{' +
        ' showLoader: $showLoader,' +
        ' hasMessage: $hasMessage,' +
        ' latLng: $latLng,' +
        '}';
  }

  CustomerDashboardState copyWith({
    bool? showLoader,
    String? hasMessage,
    LatLng? latLng,
  }) {
    return CustomerDashboardState(
      showLoader: showLoader ?? this.showLoader,
      hasMessage: hasMessage ?? this.hasMessage,
      latLng: latLng ?? this.latLng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'showLoader': this.showLoader,
      'hasMessage': this.hasMessage,
      'latLng': this.latLng,
    };
  }

  factory CustomerDashboardState.fromMap(Map<String, dynamic> map) {
    return CustomerDashboardState(
      showLoader: map['showLoader'] as bool,
      hasMessage: map['hasMessage'] as String,
      latLng: map['latLng'] as LatLng,
    );
  }

//</editor-fold>
}