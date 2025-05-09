import 'package:evencir_task/core/routes/routes.dart';
import 'package:evencir_task/view/home_page/home_page_screen.dart';
import 'package:evencir_task/view/splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EvenCir Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.splash,
      routes: {
        Routes.splash: (context) => SplashScreen(),
        Routes.home: (context) => HomePageScreen(),
      },
    );
  }
}
