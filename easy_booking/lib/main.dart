import 'package:device_preview/device_preview.dart';
import 'package:easy_booking/widget/bus_list.dart';
import 'package:easy_booking/widget/get_started.dart';
import 'package:easy_booking/widget/login.dart';

import 'package:easy_booking/widget/search_page.dart';
import 'package:easy_booking/widget/ui_example_03.dart';
import 'package:easy_booking/widget/ui_example_05.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



void main()=>runApp(DevicePreview(
enabled: !kReleaseMode,
builder: (context) => MyApp()
)
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.blue
      ),
      home: Bottom_Nav_Redbus(),
      // home: RedBusSeatUI(),
    );
  }
}


//
// import 'package:easy_booking/widget/ui_example_05.dart';
// import 'package:flutter/material.dart';
//
//
// void main()=>runApp(new MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//           brightness: Brightness.light,
//           primaryColor: Color(0xffd44d57)
//       ),
//       home: RedBusSeatUI(),
//     );
//   }
// }

