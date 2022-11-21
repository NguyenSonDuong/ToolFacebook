import 'package:flutter/material.dart';
import 'package:tool_facebook/page/home.dart';
import 'package:tool_facebook/page/home_page.dart';
import 'package:tool_facebook/page/login.dart';
import 'package:tool_facebook/page/mrcong.dart';
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
        Routes.home: (context) => HomeStatelessWidget("",0),
        Routes.login: (context) => LoginStatelessWidget(),
        Routes.nature: (context) => HomeStatelessWidget("",0),
        Routes.girl: (context) =>  HomeStatelessWidget("",1),
        Routes.hide: (context) => MrCong(),
      },
      home: HomePage(),
    );
    // return LoginStatelessWidget();
  }
}
class Routes {
  static final String home = "/home";
  static final String login = "/login";
  static final String nature = "/nature";
  static final String girl = "/girl";
  static final String hide = "/hide";

}
