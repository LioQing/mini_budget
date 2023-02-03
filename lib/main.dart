import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_budget/pages/HomePage.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(systemNavigationBarColor: Colors.transparent)
    );

    return MaterialApp(
      title: 'Mini Budget',
      theme: ThemeData(
        fontFamily: 'NotoSans',
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}


