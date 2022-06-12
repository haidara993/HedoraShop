import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hedorashop/global/bindings.dart';
import 'package:hedorashop/pages/controlview.dart';
import 'package:hedorashop/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) => ScreenUtilInit(
        designSize: orientation == Orientation.portrait
            ? Size(375, 812)
            : Size(812, 375),
        builder: () => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "hedorashop",
          initialBinding: Binding(),
          home: HomePage(),
        ),
      ),
    );
  }
}
