import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:syeda_firebase/UI/auth/Login/loginscreeen.dart';
import 'package:syeda_firebase/UI/todo/splashscreen.dart';
import 'package:syeda_firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with Realtime Database URL explicitly set
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: DefaultFirebaseOptions.android.apiKey,
      appId: DefaultFirebaseOptions.android.appId,
      messagingSenderId: DefaultFirebaseOptions.android.messagingSenderId,
      projectId: DefaultFirebaseOptions.android.projectId,
      storageBucket: DefaultFirebaseOptions.android.storageBucket,
      databaseURL:
          "https://fir-project-fa145-default-rtdb.firebaseio.com/", // Set your database URL here
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
