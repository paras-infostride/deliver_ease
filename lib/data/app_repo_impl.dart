import 'package:deliver_ease/core/utils/app_strings.dart';
import 'package:deliver_ease/core/utils/debug_logger.dart';
import 'package:deliver_ease/domain/app_repo.dart';
import 'package:deliver_ease/domain/user_profile/user_profile.dart';

import 'package:cloud_firestore/cloud_firestore.dart';


class AppRepoImpl implements AppRepo
{

  @override
  Future<void> createUserIdentity(UserProfile userProfile) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final CollectionReference mainCollection = firestore.collection(FirebaseStrings.usersCollection);

      DocumentReference documentReferencer =
      mainCollection.doc(userProfile.userId);

      await documentReferencer
          .set(userProfile.toJson())
          .whenComplete(()
      {
        return Future.value(null);
      })
          .catchError((e)
      {
        debuggerAdvance(tag: "error at createUserIdentity", value: e.toString());

       throw e.toString();

      });
    }
      catch (e) {
      rethrow;
    }
  }

}