import 'package:flutter/material.dart';
import 'package:tool_facebook/page/home.dart';
import 'package:tool_facebook/page/login.dart';
import 'package:tool_facebook/service/api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Routes.home: (context) => HomeStatelessWidget(0),
        Routes.login: (context) => LoginStatelessWidget(),
      },
      home: LoginStatelessWidget(),
    );
    // return LoginStatelessWidget();
  }
}
class Routes {
  static final String home = "/home";
  static final String login = "/login";
}
