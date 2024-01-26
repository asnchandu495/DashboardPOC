import 'package:dashboardpoc/Gauges/LinearGauge.dart';
import 'package:flutter/material.dart';

import '../../Utilities/responsive.dart';
import '../../Utilities/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';


class GaugeDetails extends StatelessWidget {
  GaugeDetails({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Container(
        height: 300,
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: colorclass.tilesBackGroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            colorclass.shadowView,
          ],
        ),
        child: Container(
          padding: EdgeInsets.only(left: 10.0,right: 10.0),
          child: LinearGauge(),
        )
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     // Text(
      //     //   "Weather Details",
      //     //   style: TextStyle(
      //     //     fontSize: 18,
      //     //     fontWeight: FontWeight.w500,
      //     //   ),
      //     // ),
      //     SizedBox(height: defaultPadding),
      //     PieChart(),
      //   ],
      // ),
    );
  }
}
