import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upload_image/screens/gallery_screen.dart';
import 'package:upload_image/styling/pallet.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setStatusBarAndNavigationBarColor(ThemeMode.light);
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
        primarySwatch: Pallet.primarySwatch,
      ),
      home: const GalleryScreen(),
    );
  }
}

const bkColor = Color(0xffE8E8E8);

void setStatusBarAndNavigationBarColor(ThemeMode themeMode) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness:
        themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
    systemNavigationBarIconBrightness:
        themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
    systemNavigationBarColor: bkColor,
    systemNavigationBarDividerColor: Colors.transparent,
  ));
}
