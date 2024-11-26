import 'package:deliver_ease/core/utils/app_strings.dart';
import 'package:deliver_ease/core/utils/debug_logger.dart';
import 'package:deliver_ease/domain/app_repo.dart';
import 'package:deliver_ease/domain/user_profile/user_profile.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'exceptions_string_constants.dart';


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


  @override
  Future<bool> checkUserExist(String userID) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final CollectionReference userCollection = firestore.collection(FirebaseStrings.usersCollection);

      final QuerySnapshot<Object?> res = await userCollection
          .where(FirebaseStrings.userIdKey, isEqualTo: userID)
          .get();

      return res.docs.isNotEmpty;
    }  catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserProfile> fetchUserDetail(String userID) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final CollectionReference userCollection = firestore.collection(FirebaseStrings.usersCollection);

      final QuerySnapshot<Object?> res = await userCollection
          .where(FirebaseStrings.userIdKey, isEqualTo: userID)
          .get();
      List<UserProfile> list = [];
      if (res.docs.isNotEmpty) {
        for (int i = 0; i < res.docs.length; i++) {
          Map<String, dynamic> fetchDoc =
          res.docs[i].data() as Map<String, dynamic>;
          list.add(UserProfile.fromJson(fetchDoc));
        }
        return list.first;
      } else {
        throw ExceptionStrings.noDataFound;
      }

    }  catch (e) {
      rethrow;
    }

  }


}