// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project_machine_test_2/features/pages/add_feeds/controller/add_feeds_controller.dart';
import 'package:project_machine_test_2/features/pages/home/controller/home_controller.dart';
import 'package:project_machine_test_2/features/pages/login/controller/login_controller.dart';
import 'package:project_machine_test_2/features/pages/login/presentation/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginController>(create: (context) => LoginController()),
        ChangeNotifierProvider<AddFeedsController>(create: (context) => AddFeedsController()),
        ChangeNotifierProvider<HomeController>(create: (context) => HomeController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [Permission.camera, Permission.storage].request();
    log("Camera permission status: ${statuses[Permission.camera]}");
    log("Storage permission status: ${statuses[Permission.storage]}");
  }

  @override
  Widget build(BuildContext context) {
    requestPermissions();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
