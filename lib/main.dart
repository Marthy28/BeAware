import 'package:be_aware/Pages/LoginScreen.dart';
import 'package:be_aware/Pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'Model/UserModel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'Model/UserModel.dart';
import 'Pages/MainPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserModel>(create: (_) => UserModel()),
      ],
      child: Consumer<UserModel>(builder: (_, settings, child) {
        return MyApp();
      }),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Raleway',
        textTheme: TextTheme(
          bodyText1: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),
          bodyText2: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
          button: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          headline5: TextStyle(
            fontWeight: FontWeight.w800 /*extrabold*/,
            fontSize: 38,
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
