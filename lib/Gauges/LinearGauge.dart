/// Package import
// import 'dart:ffi';

import 'package:dashboardpoc/Model/dashboard_model.dart';
import 'package:dashboardpoc/Utilities/constants.dart';
import 'package:flutter/material.dart';

import 'package:gauges/gauges.dart';




/// Base class of the sample's stateful widget class
class LinearGauge extends StatefulWidget {
  /// base class constructor of sample's stateful widget class
  const LinearGauge({Key? key}) : super(key: key);
  @override
  _LinearGaugeState createState() => _LinearGaugeState();
}

class _LinearGaugeState extends State<LinearGauge> {

  final double _pointerValue = double.parse( (((model.dashboardData ?? []).isNotEmpty ? (model.dashboardData![0].value ?? "") : "0").replaceAll("°C", "")).replaceAll(",", ""));



  late bool isCardView = false;
  late bool isWebView = false;

  String tempString = (model.weeklyHeaders ?? []).isNotEmpty ? (model.weeklyHeaders ?? [])[1].substring(0, 4) : "";
  String tempUnitsString = "";
  //((model.units ?? Units()).temperature ?? "").isNotEmpty ? ((model.units ?? Units()).temperature ?? ""):"";

  late String tempValue = ((model.dashboardData ?? []).isNotEmpty ? ((model.dashboardData?? [])[0].value ?? "") : "");
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width/2;
    const size = 300.0;

    //return _buildDefaultColumnChart();
    return SizedBox(
      // height: 300,
      // child: Stack(
      //   children: [
      //     _buildRadialTextPointer(),
      //   ],
      // ),

        height: 300,
        // color: Colors.deepPurple,
        child:Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              padding: EdgeInsets.only(top: size-140),
              child:  Text(
                  tempValue,
                  style: gaugeTempBoldStyle
              ),
            ),
            Column(
              children: [
                Row(
                  children:  [
                    // const Padding(padding:EdgeInsets.only(right: 5.0),),
                    Container(
                      padding: EdgeInsets.only(top: size-65,left: width-110),
                      child: const Text("  0",
                          style: titleBoldStyle,
                      ),
                    ),
                    // const Padding(padding:EdgeInsets.only(right: 90.0),),
                    // SizedBox( width: size-50,),
                    Container(
                      padding: EdgeInsets.only(top: size-65, left: 100),
                      child: const Text("100",
                          style: titleBoldStyle
                      ),
                    ),
                  ],
                ),
                Container(
                  // padding: EdgeInsets.only(top: size-70, left: width+30),
                  child:  Text(tempString,
                      style: titleBoldStyle
                  ),
                ),
              ],
            ),
            SizedBox(
              // width: size,
              // height: size,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: RadialGauge(
                  axes: [
                    // Main axis
                    RadialGaugeAxis(
                      minValue: 0,
                      maxValue: 100,
                      minAngle: -150,
                      maxAngle: 150,
                      radius: 0.6,
                      width: 0.2,
                      color: Colors.lightBlue[200],
                      // ticks: [0,10,20,30,40,50,60,70,80,90,100],
                      ticks: [
                        RadialTicks(
                            interval: 10,
                            alignment: RadialTickAxisAlignment.inside,
                            color: Colors.black,
                            length: 0.2,
                            // values: [1,2,3,4,5,6,7,8,9,10],

                            children: [
                              RadialTicks(
                                ticksInBetween: 5,
                                length: 0.1,
                                color: Colors.blueGrey,
                              ),
                            ])
                      ],
                      pointers: [
                        RadialNeedlePointer(
                          value: _pointerValue,
                          thicknessStart: 20,
                          thicknessEnd: 0,
                          color: Colors.lightBlue[200]!,
                          length: 0.6,
                          knobRadiusAbsolute: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

    );
  }
/*
  SfRadialGauge _buildRadialTextPointer() {
    return SfRadialGauge(
      animationDuration: 3500,
      enableLoadingAnimation: true,
      axes: <RadialAxis>[
        RadialAxis(
            minimum: -20,
            maximum: 100,
            interval: isCardView ? 20 : _interval,
            minorTicksPerInterval: 9,
            showAxisLine: false,
            radiusFactor: isWebView ? 0.8 : 0.9,
            labelOffset: 8,
            ranges: <GaugeRange>[
              GaugeRange(
                  startValue: -50,
                  endValue: 0,
                  startWidth: 0.265,
                  sizeUnit: GaugeSizeUnit.factor,
                  endWidth: 0.265,
                  color: const Color.fromRGBO(34, 144, 199, 0.75)),
              GaugeRange(
                  startValue: 0,
                  endValue: 10,
                  startWidth: 0.265,
                  sizeUnit: GaugeSizeUnit.factor,
                  endWidth: 0.265,
                  color: const Color.fromRGBO(34, 195, 199, 0.75)),
              GaugeRange(
                  startValue: 10,
                  endValue: 30,
                  startWidth: 0.265,
                  sizeUnit: GaugeSizeUnit.factor,
                  endWidth: 0.265,
                  color: const Color.fromRGBO(123, 199, 34, 0.75)),
              GaugeRange(
                  startValue: 30,
                  endValue: 40,
                  startWidth: 0.265,
                  sizeUnit: GaugeSizeUnit.factor,
                  endWidth: 0.265,
                  color: const Color.fromRGBO(238, 193, 34, 0.75)),
              GaugeRange(
                  startValue: 40,
                  endValue: 150,
                  startWidth: 0.265,
                  sizeUnit: GaugeSizeUnit.factor,
                  endWidth: 0.265,
                  color: const Color.fromRGBO(238, 79, 34, 0.65)),
            ],
            annotations:  <GaugeAnnotation>[
              GaugeAnnotation(
                  angle: 90,
                  positionFactor: 0.35,
                  widget: Text(((model.weeklyHeaders ?? []).isNotEmpty ? (model.weeklyHeaders ?? [])[1].substring(0, 4) : ""),
                      style: gaugeTitleStyle
                  )),
              GaugeAnnotation(
                angle: 90,
                positionFactor: 0.8,
                widget: Text(
                  ((model.dashboardData ?? []).isNotEmpty ? ((model.dashboardData?? [])[0].value ?? "").replaceAll(",", "") : "")  ,
                  style: gaugeTempBoldStyle,
                ),
                // Text(
                //   tempValue ,
                //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                // ),
              )
            ],
            pointers: <GaugePointer>[
              NeedlePointer(
                value: double.parse( (((model.dashboardData ?? []).isNotEmpty ? (model.dashboardData![0].value ?? "") : "0").replaceAll("°C", "")).replaceAll(",", "")),
                needleStartWidth: isCardView ? 0 : 1,
                needleEndWidth: isCardView ? 5 : 8,
                animationType: AnimationType.easeOutBack,
                enableAnimation: true,
                animationDuration: 1200,
                knobStyle: KnobStyle(
                    knobRadius: isCardView ? 0.06 : 0.09,
                    borderColor: const Color(0xFFF8B195),
                    color: Colors.white,
                    borderWidth: isCardView ? 0.035 : 0.05),
                tailStyle: TailStyle(
                    color: const Color(0xFFF8B195),
                    width: isCardView ? 4 : 8,
                    length: isCardView ? 0.15 : 0.2),
                needleColor: const Color(0xFFF8B195),
              )
            ],
            axisLabelStyle:
            GaugeTextStyle(fontSize: isCardView ? 10 : 12,
              color: textColor
            ),

            majorTickStyle: const MajorTickStyle(
                length: 0.25, lengthUnit: GaugeSizeUnit.factor),
            minorTickStyle: const MinorTickStyle(
                length: 0.13, lengthUnit: GaugeSizeUnit.factor, thickness: 1))
      ],
    );
  }
  double _interval = 20;

 */
}



