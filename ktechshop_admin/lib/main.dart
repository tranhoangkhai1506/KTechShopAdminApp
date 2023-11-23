import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ktechshopadmin/constants/theme.dart';
import 'package:ktechshopadmin/helper/firebase_options/firebase_options.dart';
import 'package:ktechshopadmin/provider/app_provider.dart';
import 'package:ktechshopadmin/screens/home_page/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create: (context) => AppProvider(),
      child: MaterialApp(
        title: 'Admin Panel',
        theme: themData,
        home: AnimatedSplashScreen(
          duration: 3000,
          splashTransition: SplashTransition.fadeTransition,
          splash: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 70,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Image.asset('assets/images/ktechLogo.png'),
                ),
              ],
            ),
          ),
          nextScreen: HomePage(),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
