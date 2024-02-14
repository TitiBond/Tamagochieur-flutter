import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tamagochieur/screens/home_screen.dart';
import 'package:tamagochieur/screens/loading_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const TamagoLoadingScreen(),
        '/tamago': (context) => const TamagoHomeScreen(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'ProtestRiot',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
