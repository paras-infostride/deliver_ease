class UserProfile {
  String? userId;
  String? phoneNumber;
  String? profileUrl;
  String? name;
  String? lastName;
  String? address;
  String? latitude;
  String? longitude;
  bool? isServiceProvider;
  bool? emailAddress;
  String? gender;
  String? dateOfBirth;
  String? vehicleType;
  String? vehicleNumber;
  bool? isVerified;

  //<editor-fold desc="Data Methods">
  UserProfile({
    this.userId,
    this.phoneNumber,
    this.profileUrl,
    this.name,
    this.lastName,
    this.address,
    this.latitude,
    this.longitude,
    this.isServiceProvider,
    this.emailAddress,
    this.gender,
    this.dateOfBirth,
    this.vehicleType,
    this.vehicleNumber,
    this.isVerified,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfile &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          phoneNumber == other.phoneNumber &&
          profileUrl == other.profileUrl &&
          name == other.name &&
          lastName == other.lastName &&
          address == other.address &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          isServiceProvider == other.isServiceProvider &&
          emailAddress == other.emailAddress &&
          gender == other.gender &&
          dateOfBirth == other.dateOfBirth &&
          vehicleType == other.vehicleType &&
          vehicleNumber == other.vehicleNumber &&
          isVerified == other.isVerified);

  @override
  int get hashCode =>
      userId.hashCode ^
      phoneNumber.hashCode ^
      profileUrl.hashCode ^
      name.hashCode ^
      lastName.hashCode ^
      address.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      isServiceProvider.hashCode ^
      emailAddress.hashCode ^
      gender.hashCode ^
      dateOfBirth.hashCode ^
      vehicleType.hashCode ^
      vehicleNumber.hashCode ^
      isVerified.hashCode;

  @override
  String toString() {
    return 'UserProfile{' +
        ' userId: $userId,' +
        ' phoneNumber: $phoneNumber,' +
        ' profileUrl: $profileUrl,' +
        ' name: $name,' +
        ' lastName: $lastName,' +
        ' address: $address,' +
        ' latitude: $latitude,' +
        ' longitude: $longitude,' +
        ' isServiceProvider: $isServiceProvider,' +
        ' emailAddress: $emailAddress,' +
        ' gender: $gender,' +
        ' dateOfBirth: $dateOfBirth,' +
        ' vehicleType: $vehicleType,' +
        ' vehicleNumber: $vehicleNumber,' +
        ' isVerified: $isVerified,' +
        '}';
  }

  UserProfile copyWith({
    String? userId,
    String? phoneNumber,
    String? profileUrl,
    String? name,
    String? lastName,
    String? address,
    String? latitude,
    String? longitude,
    bool? isServiceProvider,
    bool? emailAddress,
    String? gender,
    String? dateOfBirth,
    String? vehicleType,
    String? vehicleNumber,
    bool? isVerified,
  }) {
    return UserProfile(
      userId: userId ?? this.userId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileUrl: profileUrl ?? this.profileUrl,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isServiceProvider: isServiceProvider ?? this.isServiceProvider,
      emailAddress: emailAddress ?? this.emailAddress,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      vehicleType: vehicleType ?? this.vehicleType,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  UserProfile.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    phoneNumber = json['phone_number'];
    profileUrl = json['profile_url'];
    name = json['name'];
    lastName = json['last_name'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isServiceProvider = json['is_service_provider'];
    emailAddress = json['email_address'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    vehicleType = json['vehicle_type'];
    vehicleNumber = json['vehicle_number'];
    isVerified = json['is_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['phone_number'] = this.phoneNumber;
    data['profile_url'] = this.profileUrl;
    data['name'] = this.name;
    data['last_name'] = this.lastName;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['is_service_provider'] = this.isServiceProvider;
    data['email_address'] = this.emailAddress;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['vehicle_type'] = this.vehicleType;
    data['vehicle_number'] = this.vehicleNumber;
    data['is_verified'] = this.isVerified;
    return data;
  }

//</editor-fold>
}