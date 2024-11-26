import 'package:deliver_ease/core/utils/responsive_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/global_providers.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/routes/app_router.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Create a ProviderContainer to hold the providers
  final container = ProviderContainer();

  // * Preload SharedPreferences before calling runApp
  await container.read(sharedPreferencesProvider.future);

  // Pass the container to UncontrolledProviderScope
  runApp(UncontrolledProviderScope(
    container: container,
    child: MyApp(),
  ));
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    //  Initialize Responsive util

    /// WORKS on every screen EXCEPT the screen in which appBar is used
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white, // navigation bar color
          statusBarColor: Colors.white, // status bar color
          statusBarIconBrightness: Brightness.dark, // status bar icons' color
          systemNavigationBarIconBrightness: Brightness.dark,
          // ice Versa for ThemeMode.dark
      ),
    );

     Responsive.size = MediaQuery.sizeOf(context);

    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.routers,

      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


