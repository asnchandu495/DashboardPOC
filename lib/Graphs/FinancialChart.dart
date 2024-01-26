/// Package import
// import 'dart:html';

import 'package:circular_clip_route/circular_clip_route.dart';
import 'package:dashboardpoc/Model/dashboard_model.dart';
import 'package:dashboardpoc/Utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';


import '../Dashboard/Components/graph_screen.dart';
import '../Dashboard/Components/weather_details.dart';
import '../Model/sample_view.dart';

/// Base class of the sample's stateful widget class
class FinancialChart extends StatefulWidget {
  /// base class constructor of sample's stateful widget class
  FinancialChart({Key? key, required this.onTap, required this.isHidden}) : super(key: key);

  late VoidCallback onTap;
  late bool isHidden;
  @override
  _FinancialChartState createState() => _FinancialChartState(this.onTap,this.isHidden);

}

class _FinancialChartState extends State<FinancialChart> {

  _FinancialChartState(this.onTap, this.isHidden);
  late VoidCallback onTap;
  late bool isHidden;
  /// Holds the information of current page is card view or not
  late bool isCardView = false;

  List<Map<dynamic,dynamic>> chartData = [];

  double finalVal = 0.0;

  double finalMinVal = 0.0;

  String title1Unit = "";
  String title1Value = "";

  final  _avatarKey = GlobalKey();

  @override
  void initState() {
    readJson();
    super.initState();
  }

  void readJson()  {

    List<double> maxValues =[];
    for(int i=0; i<(model.weeklyData ?? []).length; i++) {
      var y2Value = double.parse((model.weeklyData![i].value6 ?? "").replaceAll(",", ""));
      maxValues.add(y2Value);
    }
    double maxVal = maxValues.reduce((value, element) => value > element ? value: element);
    double perVal = maxVal*0.4;
    finalVal = maxVal + perVal;

    List<double> minValues =[];
    for(int i=0; i<(model.weeklyData ?? []).length; i++) {
      var y2Value = double.parse((model.weeklyData![i].value5 ?? "").replaceAll(",", ""));
      minValues.add(y2Value);
    }

    double minVal = minValues.reduce((value, element) => value < element ? value: element);
    double minPerVal = minVal*0.4;

    finalMinVal = minPerVal + minVal;
    if (finalMinVal >0){
      finalMinVal = 0.0;
    }

    // List<Map<dynamic,dynamic>> readJson()  {
    for(int i=0; i<(model.weeklyData ?? []).length; i++) {
      var y1Value = double.parse((model.weeklyData![i].value5 ?? "").replaceAll(",", ""));
      var y2Value = double.parse((model.weeklyData![i].value6 ?? "").replaceAll(",", ""));
      Map formData = {"id":model.weeklyData![i].value, "min": y1Value, "max":y2Value};
      chartData.add(formData);
    }
    title1Unit = model.weeklyData![0].title1Unit ?? "";
    title1Value = '${model.weeklyData![0].title1 ?? ""}(${model.weeklyData![0].title1Unit ?? ""})';

    // return chartData;
  }

  @override
  Widget build(BuildContext context) {
    //return _buildDefaultColumnChart();
    return SizedBox(
      key: _avatarKey,
      // height: 300,
      child: Stack(
        children: [
          getChartView(),
          Visibility(
              visible: this.isHidden,
              child: Positioned(
                  right: 0.0,
                  top: 0.0,
                  child: SizedBox(
                    width: 30, // Adjust width and/or height of sized box to control button size
                    child: FloatingActionButton(
                      child: Image.asset( 'assets/images/expand.png',
                        height: 25,
                      ),
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      onPressed: () {
                        print('printed barchart');
                        Navigator.push(
                          contextLocal,
                          CircularClipRoute<void>(
                            builder: (context) =>
                                GraphView(titleValue: "Financial Chart"),
                            expandFrom: _avatarKey.currentContext!,
                            curve: Curves.easeInExpo,
                            reverseCurve: Curves.easeInCirc,
                            opacity: ConstantTween(1),
                            transitionDuration: const Duration(milliseconds: durationAnimation),
                          ),
                        );
                        // onTap();
                      },
                    ),
                  )
              )
          ),
        ],
      ),

    );

  }

  Widget getChartView() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      // width: 350,
      // height: 300,
      child: Chart(
        padding: (_) => const EdgeInsets.fromLTRB(40, 5, 10, 90),
        data: chartData,
        variables: {
          'id': Variable(
            accessor: (Map map) => map['id'] as String,
            // scale: LinearScale(tickCount: 4),
            // scale: OrdinalScale(tickCount: 4),
          ),
          'min': Variable(
            accessor: (Map map) => map['min'] as num,
            scale: LinearScale(min: finalMinVal, max: finalVal,
                formatter:(v) => '${StrIntCurrency().intToStringID(v.toInt())}${title1Unit}    '
            ),
          ),
          'max': Variable(
            accessor: (Map map) => map['max'] as num,
            scale: LinearScale(min: finalMinVal, max: finalVal,
                formatter:(v) => '${StrIntCurrency().intToStringID(v.toInt())}${title1Unit}    '
            ),
          ),
        },
        elements: [
          IntervalElement(
            position: Varset('id') * (Varset('min') + Varset('max')),
            shape: ShapeAttr(
                value: RectShape(
                    borderRadius: BorderRadius.circular(2))),
          )
        ],
        // Defaults.horizontalAxis..tickLine = TickLine(length: 10),
        // Defaults.verticalAxis..tickLine = TickLine(length: 10),
        axes: [
          Defaults.horizontalAxis
            ..grid = StrokeStyle(
                width: 1.0,
                color: Colors.black12
            )
            ..tickLine = TickLine()
            ..line = StrokeStyle(
              width: 1.2,
              color: Colors.black45,
            )
            ..label = LabelStyle(
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12.0,
                  fontWeight:FontWeight.bold,
                  decorationStyle: TextDecorationStyle.double
              ),
              rotation: 175.0,
              // minWidth: 150.0,
              align: const Alignment(-1.2,1.0),
            ),
          // ..position = 40.0,
          Defaults.verticalAxis
            ..grid = StrokeStyle(
                width: 1.0,
                color: Colors.black12
            )
            ..tickLine = TickLine(
                length: 1.0,
                style: Defaults.strokeStyle
            )
            ..line = StrokeStyle(
                width: 1.2,
                color: Colors.black45
            )
            ..label = LabelStyle(
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12.0,
                  fontWeight:FontWeight.bold,
                  decorationStyle: TextDecorationStyle.solid
              ),
              // rotation: 175.0,
              // align: const Alignment(-1.0,-1.5),
            ),
        ],
        selections: {'tap': PointSelection(dim: Dim.x)},
        tooltip: TooltipGuide(),
        crosshair: CrosshairGuide(),
          annotations: [
          MarkAnnotation(
          relativePath: Path()
          ..addRect(Rect.fromCircle(
            center: const Offset(0, 0), radius: 5)),
          style: Paint()..color = Defaults.colors10[0],
            anchor: (size) =>  Offset(size.width/2-50, size.height-10),
          ),
          TagAnnotation(
           label: Label(
            title1Value,
             LabelStyle(
                 style: const TextStyle(
                     color: Colors.black,
                     fontSize: 12.0,
                     fontWeight:FontWeight.bold,
                     decorationStyle: TextDecorationStyle.solid
                 ),
                 align: Alignment.centerRight),
            ),
            anchor: (size) =>  Offset(size.width/2-50+8, size.height-10),
            ),
          ],
      ),
    );
  }
}


