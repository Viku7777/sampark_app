import 'package:chat_app/Config/PagePath.dart';
import 'package:chat_app/Config/Themes.dart';
import 'package:chat_app/controller/notification_controller.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NoificationRepository.notificationPlugin();

  runApp(const MyApp());
  // NotificationController().createChannel();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sampark',
      theme: lightTheme,
      darkTheme: darkTheme,
      getPages: pagePath,
      themeMode: ThemeMode.dark,
    );
  }
}
