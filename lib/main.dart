import 'package:flutter/material.dart';
import 'package:flutter_todo_app/view/screens/home.dart';
import 'package:provider/provider.dart';
import 'Controller/constants/Theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'ToDo App',
    //   home: Home(),
    // );
    return ChangeNotifierProvider(
      create: (_) => ModelTheme(),
      child: Consumer<ModelTheme>(
        builder: (
            context,
            ModelTheme themeNotifier,
            child,
            ) {
          return MaterialApp(
            theme: themeNotifier.isDark
                ? ThemeData(
              appBarTheme: AppBarTheme(color: Colors.lightBlueAccent.shade100),
              brightness: Brightness.dark,
              useMaterial3: true,
            )
                : ThemeData(
              brightness: Brightness.light,
              appBarTheme: AppBarTheme(color: Colors.lightBlueAccent.shade100),
              primaryColor: Colors.black,
              useMaterial3: true
            ),
            debugShowCheckedModeBanner: false,
            home: Home(),
          );
        },
      ),
    );
  }
}
