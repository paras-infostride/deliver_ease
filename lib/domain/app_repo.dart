

import 'package:deliver_ease/domain/goole_places/google_places_res_model.dart';
import 'package:deliver_ease/domain/user_profile/user_profile.dart';

abstract class AppRepo
{
  Future<void> createUserIdentity(UserProfile userProfile);

  Future<bool> checkUserExist(String userID);

  Future<UserProfile> fetchUserDetail(String userID);

  Future<void> updateProfile({required UserProfile userProfile});

  Future<void> deleteProfile({required String userId});

  Future<List<UserProfile>> getListOfAllServiceProvider();

  Future<void> logOut();

  Future<List<Predictions>> getSearchedLocations({required String searchedKey});

}