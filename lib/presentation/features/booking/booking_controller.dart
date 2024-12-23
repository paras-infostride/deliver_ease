import 'package:deliver_ease/core/global_providers.dart';
import 'package:deliver_ease/core/utils/debug_logger.dart';
import 'package:deliver_ease/core/utils/get_current_lat_long.dart';
import 'package:deliver_ease/domain/app_repo.dart';
import 'package:deliver_ease/domain/goole_places/google_places_res_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
final bookingControllerProvider = StateNotifierProvider.autoDispose<BookingScreenController, BookingScreenState>((ref) {
  AppRepo appRepo = ref.read(appRepoProvider);
  return BookingScreenController(
    appRepo: appRepo
  );
});

class BookingScreenController extends StateNotifier<BookingScreenState> {
  final AppRepo appRepo;

  BookingScreenController({required this.appRepo})
      : super(BookingScreenState(
      showLoader: true , hasMessage :  '' ,
      dropLatLng: null, pickUpLatLng: null,
      dropTextfieldActive: true,
      dropAddress: '',
      hasMessageForListener: '',
      listOfPlaces: [],
      pickupAddress: ''
  ));

  getCurrentLocation() async {
    try {
      state =
          state.copyWith(showLoader: true , hasMessageForListener :  '', hasMessage: '');

      Position position = await GetCurrentLatLongUtil.getCurrentPosition();
      String address =  await GetCurrentLatLongUtil.getAddressFromLatLong(position.latitude, position.longitude);
      state = state.copyWith(
        showLoader: false,
       pickupAddress: address,
        pickUpLatLng: LatLng(position.latitude, position.longitude),

      );
    }
    catch (e) {
      debuggerAdvance(tag: "At catch getCurrentLocation", value: e.runtimeType , type: DebugType.error);
      state = state.copyWith(showLoader: false, hasMessage: e.toString());
    }
  }

  getSearchedLocations({ required String value , required bool isDropTextfieldActive}) async {
    try {
       state =
          state.copyWith(hasMessageForListener :  '', hasMessage: '' ,dropTextfieldActive: isDropTextfieldActive);
       List<Predictions>  listOfPredictions =  await appRepo.getSearchedLocations(searchedKey: value);
       state = state.copyWith(
         showLoader: false,
         listOfPlaces: listOfPredictions
       );

    }
    catch (e) {
      debuggerAdvance(tag: "At catch getCurrentLocation", value: e.runtimeType , type: DebugType.error);
      state = state.copyWith( hasMessage: e.toString());
    }
  }

  onTapOnAnyLocation()
  {
    state = state.copyWith(
      listOfPlaces:  [],

    );
  }

}

class BookingScreenState {

   bool showLoader = false;
   String hasMessage = "";
   String hasMessageForListener = "";

   LatLng?  pickUpLatLng ;
   String pickupAddress = '';

   LatLng?  dropLatLng ;
   String dropAddress = '';

   List<Predictions> listOfPlaces = [];

   bool dropTextfieldActive = true;

   //<editor-fold desc="Data Methods">
  BookingScreenState({
    required this.showLoader,
    required this.hasMessage,
    required this.hasMessageForListener,
    this.pickUpLatLng,
    required this.pickupAddress,
    this.dropLatLng,
    required this.dropAddress,
    required this.listOfPlaces,
    required this.dropTextfieldActive,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BookingScreenState &&
          runtimeType == other.runtimeType &&
          showLoader == other.showLoader &&
          hasMessage == other.hasMessage &&
          hasMessageForListener == other.hasMessageForListener &&
          pickUpLatLng == other.pickUpLatLng &&
          pickupAddress == other.pickupAddress &&
          dropLatLng == other.dropLatLng &&
          dropAddress == other.dropAddress &&
          listOfPlaces == other.listOfPlaces &&
          dropTextfieldActive == other.dropTextfieldActive);

  @override
  int get hashCode =>
      showLoader.hashCode ^
      hasMessage.hashCode ^
      hasMessageForListener.hashCode ^
      pickUpLatLng.hashCode ^
      pickupAddress.hashCode ^
      dropLatLng.hashCode ^
      dropAddress.hashCode ^
      listOfPlaces.hashCode ^
      dropTextfieldActive.hashCode;

  @override
  String toString() {
    return 'BookingScreenState{' +
        ' showLoader: $showLoader,' +
        ' hasMessage: $hasMessage,' +
        ' hasMessageForListener: $hasMessageForListener,' +
        ' pickUpLatLng: $pickUpLatLng,' +
        ' pickupAddress: $pickupAddress,' +
        ' dropLatLng: $dropLatLng,' +
        ' dropAddress: $dropAddress,' +
        ' listOfPlaces: $listOfPlaces,' +
        ' dropTextfieldActive: $dropTextfieldActive,' +
        '}';
  }

  BookingScreenState copyWith({
    bool? showLoader,
    String? hasMessage,
    String? hasMessageForListener,
    LatLng? pickUpLatLng,
    String? pickupAddress,
    LatLng? dropLatLng,
    String? dropAddress,
    List<Predictions>? listOfPlaces,
    bool? dropTextfieldActive,
  }) {
    return BookingScreenState(
      showLoader: showLoader ?? this.showLoader,
      hasMessage: hasMessage ?? this.hasMessage,
      hasMessageForListener:
          hasMessageForListener ?? this.hasMessageForListener,
      pickUpLatLng: pickUpLatLng ?? this.pickUpLatLng,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      dropLatLng: dropLatLng ?? this.dropLatLng,
      dropAddress: dropAddress ?? this.dropAddress,
      listOfPlaces: listOfPlaces ?? this.listOfPlaces,
      dropTextfieldActive: dropTextfieldActive ?? this.dropTextfieldActive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'showLoader': this.showLoader,
      'hasMessage': this.hasMessage,
      'hasMessageForListener': this.hasMessageForListener,
      'pickUpLatLng': this.pickUpLatLng,
      'pickupAddress': this.pickupAddress,
      'dropLatLng': this.dropLatLng,
      'dropAddress': this.dropAddress,
      'listOfPlaces': this.listOfPlaces,
      'dropTextfieldActive': this.dropTextfieldActive,
    };
  }

  factory BookingScreenState.fromMap(Map<String, dynamic> map) {
    return BookingScreenState(
      showLoader: map['showLoader'] as bool,
      hasMessage: map['hasMessage'] as String,
      hasMessageForListener: map['hasMessageForListener'] as String,
      pickUpLatLng: map['pickUpLatLng'] as LatLng,
      pickupAddress: map['pickupAddress'] as String,
      dropLatLng: map['dropLatLng'] as LatLng,
      dropAddress: map['dropAddress'] as String,
      listOfPlaces: map['listOfPlaces'] as List<Predictions>,
      dropTextfieldActive: map['dropTextfieldActive'] as bool,
    );
  }

//</editor-fold>

}