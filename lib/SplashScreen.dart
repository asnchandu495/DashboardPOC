import 'dart:async';
import 'dart:convert';
import 'package:dashboardpoc/HomePage/main_screen.dart';
import 'package:dashboardpoc/Model/dashboard_model.dart';
import 'package:dashboardpoc/Utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: SplashScreenAnimation(),
    );
  }
}

class SplashScreenAnimation extends StatefulWidget {
  const SplashScreenAnimation({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreenAnimation> with SingleTickerProviderStateMixin {

  var _visible = true;

  late AnimationController animationController;
  late Animation<double> animation;

  startTime() async {
    var _duration = const Duration(seconds: 5);
    return  Timer(_duration, navigationPage);
  }

  void navigationPage() {
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => QandAScreen()));
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen()));

  }

  Future<void> readJson() async {
    // final String response = await rootBundle.loadString('assets/FinancialReport.json');
    final String response = await rootBundle.loadString(dataPath);
    final data = await json.decode(response);
    final parsed = dashboard_model.fromJson(data);
    setState(() {
      model = parsed;
      print(model.companyname);
    });
  }
  @override
  void initState() {
    super.initState();
    animationController =  AnimationController(
        vsync: this, duration:  Duration(seconds: 3));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => setState(() {}));
    animationController.forward();

    setState(() {
      readJson();
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/sutherlandlogo.png',
                width: animation.value * 250,
                height: animation.value * 250,
              ),
            ],
          ),
        ],
      ),
    );
  }
}