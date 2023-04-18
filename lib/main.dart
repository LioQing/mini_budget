import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_budget/pages/HomePage.dart';
import 'package:provider/provider.dart';
import 'package:mini_budget/utilities/Storage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(systemNavigationBarColor: Colors.transparent)
    );

    return ChangeNotifierProvider<Storage>(
      create: (context) => Storage.instanced(),
      child: MaterialApp(
        title: 'Mini Budget',
        theme: ThemeData(
          fontFamily: 'NotoSans',
          useMaterial3: true,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}


