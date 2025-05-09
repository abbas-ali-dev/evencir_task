import 'package:evencir_task/provider/product_page_provider.dart';
import 'package:evencir_task/view/home_page/home_page_screen.dart';
import 'package:evencir_task/view/splash/splash_screen.dart';
import 'package:evencir_task/widgets/loader/easy_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Easyloding.configLoading();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductPageProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EvenCir Task',
        builder: EasyLoading.init(),
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              color: Colors.white,
              elevation: 0,
            )),
        home: const SplashScreen(),
        routes: {
          '/home': (context) => const HomePageScreen(),
        },
      ),
    );
  }
}
