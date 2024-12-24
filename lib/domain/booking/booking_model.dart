import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  String? bookingId;
  String? senderUserId;
  String? senderName;
  String? senderAddress;
  String? senderPhoneNumber;
  String? senderLandmark;
  String? senderLat;
  String? senderLng;
  String? receiverUserId;
  String? receiverName;
  String? receiverAddress;
  String? receiverPhoneNumber;
  String? receiverLandmark;
  String? receiverLat;
  String? receiverLng;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  String? packageType;

//<editor-fold desc="Data Methods">
  BookingModel({
    this.bookingId,
    this.senderUserId,
    this.senderName,
    this.senderAddress,
    this.senderPhoneNumber,
    this.senderLandmark,
    this.senderLat,
    this.senderLng,
    this.receiverUserId,
    this.receiverName,
    this.receiverAddress,
    this.receiverPhoneNumber,
    this.receiverLandmark,
    this.receiverLat,
    this.receiverLng,
    this.createdAt,
    this.updatedAt,
    this.packageType,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BookingModel &&
          runtimeType == other.runtimeType &&
          bookingId == other.bookingId &&
          senderUserId == other.senderUserId &&
          senderName == other.senderName &&
          senderAddress == other.senderAddress &&
          senderPhoneNumber == other.senderPhoneNumber &&
          senderLandmark == other.senderLandmark &&
          senderLat == other.senderLat &&
          senderLng == other.senderLng &&
          receiverUserId == other.receiverUserId &&
          receiverName == other.receiverName &&
          receiverAddress == other.receiverAddress &&
          receiverPhoneNumber == other.receiverPhoneNumber &&
          receiverLandmark == other.receiverLandmark &&
          receiverLat == other.receiverLat &&
          receiverLng == other.receiverLng &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          packageType == other.packageType);

  @override
  int get hashCode =>
      bookingId.hashCode ^
      senderUserId.hashCode ^
      senderName.hashCode ^
      senderAddress.hashCode ^
      senderPhoneNumber.hashCode ^
      senderLandmark.hashCode ^
      senderLat.hashCode ^
      senderLng.hashCode ^
      receiverUserId.hashCode ^
      receiverName.hashCode ^
      receiverAddress.hashCode ^
      receiverPhoneNumber.hashCode ^
      receiverLandmark.hashCode ^
      receiverLat.hashCode ^
      receiverLng.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      packageType.hashCode;

  @override
  String toString() {
    return 'BookingModel{' +
        ' bookingId: $bookingId,' +
        ' senderUserId: $senderUserId,' +
        ' senderName: $senderName,' +
        ' senderAddress: $senderAddress,' +
        ' senderPhoneNumber: $senderPhoneNumber,' +
        ' senderLandmark: $senderLandmark,' +
        ' senderLat: $senderLat,' +
        ' senderLng: $senderLng,' +
        ' receiverUserId: $receiverUserId,' +
        ' receiverName: $receiverName,' +
        ' receiverAddress: $receiverAddress,' +
        ' receiverPhoneNumber: $receiverPhoneNumber,' +
        ' receiverLandmark: $receiverLandmark,' +
        ' receiverLat: $receiverLat,' +
        ' receiverLng: $receiverLng,' +
        ' createdAt: $createdAt,' +
        ' updatedAt: $updatedAt,' +
        ' packageType: $packageType,' +
        '}';
  }

  BookingModel copyWith({
    String? bookingId,
    String? senderUserId,
    String? senderName,
    String? senderAddress,
    String? senderPhoneNumber,
    String? senderLandmark,
    String? senderLat,
    String? senderLng,
    String? receiverUserId,
    String? receiverName,
    String? receiverAddress,
    String? receiverPhoneNumber,
    String? receiverLandmark,
    String? receiverLat,
    String? receiverLng,
    Timestamp? createdAt,
    Timestamp? updatedAt,
    String? packageType,
  }) {
    return BookingModel(
      bookingId: bookingId ?? this.bookingId,
      senderUserId: senderUserId ?? this.senderUserId,
      senderName: senderName ?? this.senderName,
      senderAddress: senderAddress ?? this.senderAddress,
      senderPhoneNumber: senderPhoneNumber ?? this.senderPhoneNumber,
      senderLandmark: senderLandmark ?? this.senderLandmark,
      senderLat: senderLat ?? this.senderLat,
      senderLng: senderLng ?? this.senderLng,
      receiverUserId: receiverUserId ?? this.receiverUserId,
      receiverName: receiverName ?? this.receiverName,
      receiverAddress: receiverAddress ?? this.receiverAddress,
      receiverPhoneNumber: receiverPhoneNumber ?? this.receiverPhoneNumber,
      receiverLandmark: receiverLandmark ?? this.receiverLandmark,
      receiverLat: receiverLat ?? this.receiverLat,
      receiverLng: receiverLng ?? this.receiverLng,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      packageType: packageType ?? this.packageType,
    );
  }

  BookingModel.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    senderUserId = json['sender_user_id'];
    senderName = json['sender_name'];
    senderAddress = json['sender_address'];
    senderPhoneNumber = json['sender_phone_number'];
    senderLandmark = json['sender_landmark'];
    senderLat = json['sender_lat'];
    senderLng = json['sender_lng'];
    receiverUserId = json['receiver_user_id'];
    receiverName = json['receiver_name'];
    receiverAddress = json['receiver_address'];
    receiverPhoneNumber = json['receiver_phone_number'];
    receiverLandmark = json['receiver_landmark'];
    receiverLat = json['receiver_lat'];
    receiverLng = json['receiver_lng'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    packageType = json['package_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['sender_user_id'] = this.senderUserId;
    data['sender_name'] = this.senderName;
    data['sender_address'] = this.senderAddress;
    data['sender_phone_number'] = this.senderPhoneNumber;
    data['sender_landmark'] = this.senderLandmark;
    data['sender_lat'] = this.senderLat;
    data['sender_lng'] = this.senderLng;
    data['receiver_user_id'] = this.receiverUserId;
    data['receiver_name'] = this.receiverName;
    data['receiver_address'] = this.receiverAddress;
    data['receiver_phone_number'] = this.receiverPhoneNumber;
    data['receiver_landmark'] = this.receiverLandmark;
    data['receiver_lat'] = this.receiverLat;
    data['receiver_lng'] = this.receiverLng;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['package_type'] = this.packageType;
    return data;
  }

//</editor-fold>
}
