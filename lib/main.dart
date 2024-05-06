import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exohealandroid/screens/auth/login.dart';
import 'package:exohealandroid/screens/auth/signup.dart';
import 'package:exohealandroid/screens/base/base.dart';
import 'package:exohealandroid/screens/initial/splashscreen.dart';
import 'package:exohealandroid/screens/pairing/mainpair.dart';
import 'package:exohealandroid/services/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemma/flutter_gemma.dart';

void main() async{
  runApp(const MyApp());
  WidgetsBinding.instance.addPostFrameCallback((_) {
    print("WidgetsBinding");
  });


  FlutterGemmaPlugin.instance.init(
    maxTokens: 512,
    temperature: 1.0,
    topK: 1,
    randomSeed: 1,
  );
  await Firebase.initializeApp();
  final remoteConfig = FirebaseRemoteConfig.instance;
  NotificationService().initPushNotifications();

  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(hours: 1),
  ));

  remoteConfig.fetchAndActivate();

  await remoteConfig.setDefaults(const {
    "Exercises": '{}',

  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
      '/SignUp': (BuildContext context) => SignUp(),
      '/Login': (BuildContext context) => Login(),
      '/Base': (BuildContext context) => Base(),
    },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async{
    FirebaseFirestore.instance.collection("Test collection").add({
      "test":"here you go"});
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
