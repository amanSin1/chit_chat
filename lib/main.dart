import 'dart:io';

import 'package:demu_chat/theme/theme_provider.dart';
import 'package:demu_chat/pages/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDfQ-aL-6owVnOVE3_-675lUPPyfdCfaVk",
      appId: "1:635529589851:android:48f4b67e18bde20d297b7e",
      messagingSenderId: "635529589851",
      projectId: "hellowchat-c266f",
    ),
  )
  :await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      ChangeNotifierProvider(
          create:(context) => ThemeProvider(),
        child:const MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const Wrapper(),


    );
  }
}
