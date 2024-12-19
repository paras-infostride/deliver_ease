class UserProfile {
  String? userId;
  String? phoneNumber;
  String? profileUrl;
  String? name;
  String? lastName;
  String? address;
  double? latitude;
  double? longitude;
  bool? isServiceProvider;
  String? emailAddress;
  String? gender;
  String? dateOfBirth;
  String? vehicleType;
  String? vehicleNumber;
  bool? isVerified;
  bool? isServiceProviderActive;

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
    this.isServiceProviderActive,
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
          isVerified == other.isVerified &&
          isServiceProviderActive == other.isServiceProviderActive);

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
      isVerified.hashCode ^
      isServiceProviderActive.hashCode;

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
        ' isServiceProviderActive: $isServiceProviderActive,' +
        '}';
  }

  UserProfile copyWith({
    String? userId,
    String? phoneNumber,
    String? profileUrl,
    String? name,
    String? lastName,
    String? address,
    double? latitude,
    double? longitude,
    bool? isServiceProvider,
    String? emailAddress,
    String? gender,
    String? dateOfBirth,
    String? vehicleType,
    String? vehicleNumber,
    bool? isVerified,
    bool? isServiceProviderActive,
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
      isServiceProviderActive:
          isServiceProviderActive ?? this.isServiceProviderActive,
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
    isServiceProviderActive = json['is_service_provider_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['phone_number'] = phoneNumber;
    data['profile_url'] = profileUrl;
    data['name'] = name;
    data['last_name'] = lastName;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['is_service_provider'] = isServiceProvider;
    data['email_address'] = emailAddress;
    data['gender'] = gender;
    data['date_of_birth'] = dateOfBirth;
    data['vehicle_type'] = vehicleType;
    data['vehicle_number'] = vehicleNumber;
    data['is_verified'] = isVerified;
    data['is_service_provider_active'] = isServiceProviderActive;
    return data;
  }

//</editor-fold>
}
