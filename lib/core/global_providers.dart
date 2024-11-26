import 'package:deliver_ease/data/app_repo_impl.dart';
import 'package:deliver_ease/domain/app_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';


part 'global_providers.g.dart';

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(Ref ref) {
  return SharedPreferences.getInstance();
}

@Riverpod(keepAlive: true)
AppRepo appRepo(Ref ref) {
  return AppRepoImpl();
}
