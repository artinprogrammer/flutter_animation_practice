import 'package:flutter/material.dart';
import 'package:flutter_animation_practice/features/search_feature/domain/entity/user.dart';
import 'package:flutter_animation_practice/features/search_feature/presentation/screens/home_screen.dart';
import 'package:flutter_animation_practice/service_locator.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
