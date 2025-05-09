import 'package:evencir_task/core/routes/routes.dart';
import 'package:evencir_task/view/home_page/home_page_screen.dart';
import 'package:evencir_task/view/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class AppPages {
  static Map<String, WidgetBuilder> get routes {
    return {
      Routes.splash: (context) => const SplashScreen(),
      Routes.home: (context) => const HomePageScreen(),
    };
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(
          child: Text('No route defined for ${settings.name}'),
        ),
      ),
    );
  }
}
