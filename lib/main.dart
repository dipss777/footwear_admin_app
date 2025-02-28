import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:footware_admin/controller/home_controller.dart';
import 'package:footware_admin/firebase_option.dart';
import 'package:footware_admin/pages/home_page.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseOptions);
  Get.put(HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Footware Admin',
      home: const HomePage(),
    );
  }
}

