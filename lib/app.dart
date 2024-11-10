import 'package:flutter/material.dart';
import 'package:flutter_state_management/screens/home.dart';
import 'package:flutter_state_management/screens/info.dart';
import 'package:flutter_state_management/screens/users.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter State Management Application',
      initialRoute: "/",
      routes: {
        "/": (context) => const Home(),
        "/info": (context) => const Info(),
        "/users": (context) => const Users(),
      },
    );
  }
}
