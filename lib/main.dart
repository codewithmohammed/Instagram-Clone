import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instragram_clone/firebase_options.dart';
import 'package:instragram_clone/screens/signup_screen.dart';
import 'package:instragram_clone/utils/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .whenComplete(() {
    print("FireBase Initialized");
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        home:
            //  const ResponsiveLayout(
            //   mobileScreenLayout: MobileScreenLayout(),
            //   webScreenLayout: WebScreenLayout(),
            // )
            const SignupScreen());
  }
}
