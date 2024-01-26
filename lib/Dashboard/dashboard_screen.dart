
import 'package:dashboardpoc/Dashboard/Components/Header.dart';
import 'package:dashboardpoc/Dashboard/Components/MyFiles.dart';
import 'package:dashboardpoc/Dashboard/Components/gauge_details.dart';
import 'package:dashboardpoc/Dashboard/Components/recent_files.dart';
import 'package:dashboardpoc/Dashboard/Components/weather_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Utilities/responsive.dart';
import '../../Utilities/constants.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: SingleChildScrollView(
          primary: false,
          child: Column(
            children: [
              // Header(),
              // SizedBox(height: defaultPadding),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          // MyFiles(),
                          if (Responsive.isMobile(context))
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding:const EdgeInsets.only(left: 10,right: 10,top: 5, bottom: 10),
                                child: const Text("Weather Report",
                                  textAlign: TextAlign.left,
                                  style: gaugeTempBoldStyle,
                                ),
                              ),
                            ),
                          if (Responsive.isMobile(context)) WeatherDetails(),
                          SizedBox(height: defaultPadding),
                          // if (Responsive.isMobile(context)) WeatherDetails(),
                          if (Responsive.isMobile(context))
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding:const EdgeInsets.only(left: 10,right: 10,top: 0, bottom: 10),
                                child: const Text("Weather Daily Report",
                                  textAlign: TextAlign.left,
                                  style: gaugeTempBoldStyle,
                                ),
                              ),
                            ),
                          if (Responsive.isMobile(context)) MyFiles(),
                          SizedBox(height: defaultPadding),
                          if (Responsive.isMobile(context))
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding:const EdgeInsets.only(left: 10,right: 10,top: 0, bottom: 10),
                                child: const Text("Weather Report List",
                                  textAlign: TextAlign.left,
                                  style: gaugeTempBoldStyle,
                                ),
                              ),
                            ),
                           RecentFiles(),
                          if (Responsive.isMobile(context))
                          //   SizedBox(height: defaultPadding),
                          //  // if (Responsive.isMobile(context)) WeatherDetails(),
                          // if (Responsive.isMobile(context)) MyFiles(),
                          if (Responsive.isMobile(context))
                            SizedBox(height: defaultPadding),

                          if (Responsive.isMobile(context))
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding:const EdgeInsets.only(left: 10,right: 10,top: 0, bottom: 10),
                                child: const Text("Temperature Status",
                                  textAlign: TextAlign.left,
                                  style: gaugeTempBoldStyle,
                                ),
                              ),
                            ),
                          if (Responsive.isMobile(context)) GaugeDetails(),
                        ],
                      ),
                    ),
                    if (!Responsive.isMobile(context))
                      SizedBox(width: defaultPadding),
                    if (!Responsive.isMobile(context))
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            WeatherDetails(),
                            SizedBox(height: defaultPadding),
                            GaugeDetails(),
                          ],
                        ),
                      ),
                  ],
                ),
               )
            ],
          ),
        )
    );
  }

}