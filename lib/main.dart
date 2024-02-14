import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:vansale/screens/login/login.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';

//import 'basic_theme.dart';

main() async  {
  runApp(MyApp());
  configLoading();
}

/*void main() {
  runApp(MyApp());
  configLoading();
}*/

void changeColors(int ccolors) {}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
//ensures portrait at all times. you can override this if necessary
    ]);
    return MaterialApp(
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [const Locale('en'), const Locale('th')],
      debugShowCheckedModeBanner: false,
      theme: themeColor_(),
      home: Login(),
      builder: EasyLoading.init(),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45
    ..textColor = Colors.black
    ..radius = 10
    ..backgroundColor = Colors.transparent
    ..maskColor = Colors.white
    ..indicatorColor = Colors.black54
    ..userInteractions = false
    ..dismissOnTap = false
    ..boxShadow = <BoxShadow>[]
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle;
}

themeColor_() {
  return ThemeData(
    scaffoldBackgroundColor: HexColor('#f6f6f6'),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.green,
      elevation: 0.0,
      titleTextStyle: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        fontFamily: "Prompt",
        color: Colors.black,
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
    ),
    fontFamily: "Prompt",
    backgroundColor: HexColor('#ffffff'),
    primaryColor: HexColor('#ffffff'),
    cardColor: Colors.white,
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Colors.black,
        fontFamily: "Prompt",
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
