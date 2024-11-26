

import 'package:deliver_ease/domain/user_profile/user_profile.dart';

abstract class AppRepo
{
  Future<void> createUserIdentity(UserProfile userProfile);

}