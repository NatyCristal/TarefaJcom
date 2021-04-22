import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:provider/provider.dart';
import 'controller/principal_controller.dart';
import 'view/principal.dart';

// Firebase

bool USE_FIRESTORE_EMULATOR = false;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (USE_FIRESTORE_EMULATOR) {
    FirebaseFirestore.instance.settings = Settings(
        host: 'localhost:8080', sslEnabled: false, persistenceEnabled: false);
  }
  



  runApp(MultiProvider(
  
    providers: [
      Provider<PrincipalController>(
        create: (_) => PrincipalController(),
      )
    ],
    child: MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      home: Principal(),
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false ,
    ),
  ));
}
