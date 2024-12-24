import 'package:deliver_ease/core/utils/debug_logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookingMoreDetailControllerProvider = StateNotifierProvider.autoDispose<BookingMoreDetailScreenController, BookingMoreDetailScreenState>((ref) {
  return BookingMoreDetailScreenController();
});


class BookingMoreDetailScreenController extends StateNotifier<BookingMoreDetailScreenState> {


  BookingMoreDetailScreenController()
      : super(BookingMoreDetailScreenState(
    showLoader: false,
    hasMessage: "",
    hasMessageForListener: ''
  ));


    makeBooking() async {
    try {
      state =
          state.copyWith(showLoader: true ,hasMessage: '');
      // List<HomeResItemModel> res = await ref.getContentForHomeScreen();
      // List<HomeResItemModel> res = await _repository.getContentForHomeScreen();
      state = state.copyWith(
        showLoader: false,
      );
    }

    catch (e) {
      debuggerAdvance(tag: "At Catch Login Controller", value: e.runtimeType);
      state = state.copyWith(showLoader: false, hasMessage: e.toString());
    }
  }

}



class BookingMoreDetailScreenState {

  bool showLoader = false;
  String hasMessage = "";
  String hasMessageForListener = '';

//<editor-fold desc="Data Methods">
  BookingMoreDetailScreenState({
    required this.showLoader,
    required this.hasMessage,
    required this.hasMessageForListener,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BookingMoreDetailScreenState &&
          runtimeType == other.runtimeType &&
          showLoader == other.showLoader &&
          hasMessage == other.hasMessage &&
          hasMessageForListener == other.hasMessageForListener);

  @override
  int get hashCode =>
      showLoader.hashCode ^
      hasMessage.hashCode ^
      hasMessageForListener.hashCode;

  @override
  String toString() {
    return 'BookingMoreDetailScreenState{' +
        ' showLoader: $showLoader,' +
        ' hasMessage: $hasMessage,' +
        ' hasMessageForListener: $hasMessageForListener,' +
        '}';
  }

  BookingMoreDetailScreenState copyWith({
    bool? showLoader,
    String? hasMessage,
    String? hasMessageForListener,
  }) {
    return BookingMoreDetailScreenState(
      showLoader: showLoader ?? this.showLoader,
      hasMessage: hasMessage ?? this.hasMessage,
      hasMessageForListener:
          hasMessageForListener ?? this.hasMessageForListener,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'showLoader': this.showLoader,
      'hasMessage': this.hasMessage,
      'hasMessageForListener': this.hasMessageForListener,
    };
  }

  factory BookingMoreDetailScreenState.fromMap(Map<String, dynamic> map) {
    return BookingMoreDetailScreenState(
      showLoader: map['showLoader'] as bool,
      hasMessage: map['hasMessage'] as String,
      hasMessageForListener: map['hasMessageForListener'] as String,
    );
  }

//</editor-fold>
}