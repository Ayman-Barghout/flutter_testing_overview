import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/Presentation/app.dart';
import 'package:testing/Data/storage_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  GetIt.I.registerSingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );

  GetIt.I.registerSingleton<StorageService>(
    SharedPreferencesStorageService(GetIt.I<SharedPreferences>()),
  );

  runApp(const TestApp());
}
