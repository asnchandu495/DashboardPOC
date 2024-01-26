import 'dart:async';

import 'package:dashboardpoc/Dashboard/dashboard_screen.dart';
import 'package:dashboardpoc/Model/dashboard_model.dart';
import 'package:dashboardpoc/SideMenu/MenuController.dart';
import 'package:dashboardpoc/SideMenu/side_menu.dart';
import 'package:dashboardpoc/Utilities/constants.dart';
import 'package:dashboardpoc/Utilities/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Utilities/responsive.dart';
import 'package:provider/provider.dart';
import 'dart:convert';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  // late Timer timer;
  LinearGradient gradientValue = WeatherModel().getBackgroundColorWeather(weatherBackgroundList[0]);


  String viewTitle = (model.menuItems ?? []).isNotEmpty ? ((model.menuItems ?? [])[0].title ?? ""):"";


  WeatherModel weather = WeatherModel();

  int index = 0;

  var counter = 0;

  late Timer timer;

  Future<void> updateGradient() async {

    setState(() {
      index = index + 1;
      // animate the color
      gradientValue = weather.getBackgroundColorWeather(weatherBackgroundList[index]);
      if (index+1 == weatherBackgroundList.length) {
        index = 0;
      }
    });
  }
  // Future<void> readJson() async {
  //   // final String response = await rootBundle.loadString('assets/FinancialReport.json');
  //   final String response = await rootBundle.loadString(dataPath);
  //   final data = await json.decode(response);
  //   final parsed = dashboard_model.fromJson(data);
  //   setState(() {
  //     model = parsed;
  //     print(model.companyname);
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      // this.readJson();
      // _startBgColorAnimationTimer();


      // print(this.makeData());
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }


  _startBgColorAnimationTimer() {
    ///Animating for the first time.
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      counter++;
      setState(() {
        index = index + 1;
        // animate the color
        gradientValue = weather.getBackgroundColorWeather(weatherBackgroundList[index]);
        if (index+1 == weatherBackgroundList.length) {
          index = 0;
        }
      });
    });

    const interval = Duration(seconds: 5);
    Timer.periodic(
      interval,
          (Timer timer) {
        counter++;
        setState(() {
          index = index + 1;
          // animate the color
          gradientValue = weather.getBackgroundColorWeather(weatherBackgroundList[index]);
          if (index+1 == weatherBackgroundList.length) {
            index = 0;
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('$viewTitle         '),
        ),
        //Text(model.profile!.viewTitle ?? ""),
        flexibleSpace: Container(
            decoration:BoxDecoration(
              gradient:colorclass.gradientValue,
            )
        ),
      ),
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body:  Stack(
          children: [
            AnimatedContainer(
               duration: Duration(seconds: 5),

              decoration: BoxDecoration(
                  gradient:colorclass.menuBarGradient,
                  boxShadow: [
                    colorclass.shadowView,
                  ]
              ),
            ),
            Positioned.fill(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // We want this side menu only for large screen
                  if (Responsive.isDesktop(context))
                    Expanded(
                      // default flex = 1
                      // and it takes 1/6 part of the screen
                      child: SideMenu(),
                    ),
                  Expanded(
                    // It takes 5/6 part of the screen
                    flex: 5,
                    child: DashboardScreen(),
                  ),
                ],
              ),
            )
          ],
        ),


        /*
        Container(
          decoration:   BoxDecoration(
            gradient: weather.getBackgroundColorWeather("10n"),

            // LinearGradient(
            //   colors: [
            //    // const Color(0xFFE58C8A),
            //    //  const Color(0xFFEEC0C6),
            //     Colors.white,
            //     Colors.white70
            //   ],
            //   //   colors:[Colors.blue,   Color(0xFFFFD600)],
            //     begin:  FractionalOffset(0.0, 0.0),
            //     end:  FractionalOffset(1.0, 0.0),
            //     stops: [0.0, 1.0],
            //     tileMode: TileMode.mirror),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SideMenu(),
                ),
              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: DashboardScreen(),
              ),
            ],
          ),
        ) */


    );
  }





  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     key: context.read<MenuController>().scaffoldKey,
  //     drawer: SideMenu(),
  //     body: SafeArea(
  //         child: Container(
  //           decoration:   BoxDecoration(
  //             gradient: weather.getBackgroundColorWeather("10n"),
  //
  //             // LinearGradient(
  //             //   colors: [
  //             //    // const Color(0xFFE58C8A),
  //             //    //  const Color(0xFFEEC0C6),
  //             //     Colors.white,
  //             //     Colors.white70
  //             //   ],
  //             //   //   colors:[Colors.blue,   Color(0xFFFFD600)],
  //             //     begin:  FractionalOffset(0.0, 0.0),
  //             //     end:  FractionalOffset(1.0, 0.0),
  //             //     stops: [0.0, 1.0],
  //             //     tileMode: TileMode.mirror),
  //           ),
  //           child: Row(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               // We want this side menu only for large screen
  //               if (Responsive.isDesktop(context))
  //                 Expanded(
  //                   // default flex = 1
  //                   // and it takes 1/6 part of the screen
  //                   child: SideMenu(),
  //                 ),
  //               Expanded(
  //                 // It takes 5/6 part of the screen
  //                 flex: 5,
  //                 child: DashboardScreen(),
  //               ),
  //             ],
  //           ),
  //         )
  //
  //     ),
  //   );
  // }
}

