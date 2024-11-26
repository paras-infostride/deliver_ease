import 'package:deliver_ease/data/app_repo_impl.dart';
import 'package:deliver_ease/domain/app_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


part 'global_providers.g.dart';

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(Ref ref) {
  return SharedPreferences.getInstance();
}

@Riverpod(keepAlive: true)
AppRepo appRepo(Ref ref) {
  return AppRepoImpl();
}

final connectivityStreamProvider = StreamProvider<List<ConnectivityResult>>((ref) async* {
  yield* Connectivity().onConnectivityChanged;
});
