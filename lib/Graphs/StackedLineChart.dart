/// Package import
// import 'dart:ffi';
import 'dart:ui';

import 'package:circular_clip_route/circular_clip_route.dart';
import 'package:dashboardpoc/Model/dashboard_model.dart';
import 'package:dashboardpoc/Utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

import '../Dashboard/Components/graph_screen.dart';
import '../Dashboard/Components/weather_details.dart';
import '../Model/sample_view.dart';

/// Base class of the sample's stateful widget class
class StackedLineChart extends StatefulWidget {
  /// base class constructor of sample's stateful widget class
   StackedLineChart({Key? key, required this.onTap, required this.isHidden}) : super(key: key);
  late VoidCallback onTap;
  late bool isHidden;
  @override
  _StackedLineChartState createState() => _StackedLineChartState(this.onTap, this.isHidden);
}

class _StackedLineChartState extends State<StackedLineChart> {

  _StackedLineChartState(this.onTap, this.isHidden);
  late VoidCallback onTap;
  late bool isHidden;

  /// Holds the information of current page is card view or not
  late bool isCardView = false;
  List<Map<dynamic,dynamic>> chartData = [];

  double finalMaxVal = 0.0;
  double finalMinVal = 0.0;

  String title1Unit = "";
  String title2Unit = "";

  final  _avatarKey = GlobalKey();

  @override
  void initState() {
    readJson();
    super.initState();
  }

  void readJson()  {
    // List<Map<dynamic,dynamic>> readJson()  {

    List<double> maxValues =[];
    for(int i=0; i<(model.weeklyData ?? []).length; i++) {
      var y1Value = double.parse((model.weeklyData![i].value1 ?? "").replaceAll(",", ""));
      var y2Value = double.parse((model.weeklyData![i].value2 ?? "").replaceAll(",", ""));
      maxValues.add(y1Value);
      maxValues.add(y2Value);
    }

    double maxVal = maxValues.reduce((value, element) => value > element ? value: element);
    double perVal = maxVal*0.4;

    finalMaxVal = maxVal + perVal ;

    double minVal = maxValues.reduce((value, element) => value < element ? value: element);
    double minPerVal = minVal*0.4;

    finalMinVal = minPerVal + minVal;

    if (finalMinVal > 0){
      finalMinVal = 0.0;
    }

    for(int i=0; i<(model.weeklyData ?? []).length; i++) {
      var y1Value = double.parse((model.weeklyData![i].value1 ?? "").replaceAll(",", ""));
      var y2Value = double.parse((model.weeklyData![i].value2 ?? "").replaceAll(",", ""));

      Map formData1 = {"day":'${model.weeklyData![i].value ?? ""}', "value":y1Value,'title': 'Highest', "group":'${model.weeklyData![0].title1 ?? ""}(${model.weeklyData![0].title1Unit ?? ""})'};
      Map formData2 = {"day":'${model.weeklyData![i].value ?? ""}', "value":y2Value,'title': 'Lowest', "group":'${model.weeklyData![0].title2 ?? ""}(${model.weeklyData![0].title2Unit ?? ""})'};
     // Map formData1 = {'day': 'Mon${i}', 'value': 10, 'group': 'Highest'}
      chartData.add(formData1);
      chartData.add(formData2);

    }
    print(chartData);
    title1Unit = '${model.weeklyData![0].title1 ?? ""}(${model.weeklyData![0].title1Unit ?? ""})';
    title2Unit = '${model.weeklyData![0].title2 ?? ""}(${model.weeklyData![0].title2Unit ?? ""})';
    // return chartData;
  }

  @override
  Widget build(BuildContext context) {
    // return _buildDefaultLineChart();
    return SizedBox(
      key: _avatarKey,
      // height: 300,
      child: Stack(
        children: [
          _buildStackedLineChart(),
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
                                GraphView(titleValue: "StackedLine Chart"),
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

  /// Returns the cartesian stacked line chart.
  Widget _buildStackedLineChart() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Chart(
        padding: (_) => const EdgeInsets.fromLTRB(30, 5, 10, 100),
        data: chartData,
        variables: {
          'day': Variable(
            accessor: (Map datum) => datum['day'] as String,
            // scale: OrdinalScale(inflate: true),
            // scale: OrdinalScale(tickCount: 4),
          ),
          'value': Variable(
            accessor: (Map datum) => datum['value'] as num,
            scale: LinearScale(
              max: finalMaxVal,
              min: finalMinVal,
              tickCount: 7,
                formatter:(v) => '${StrIntCurrency().intToStringID(v.toInt())}    '
            ),
          ),
          'group': Variable(
            accessor: (Map datum) => datum['group'] as String,
          ),
        },
        elements: [
          LineElement(
            position:
            Varset('day') * Varset('value') / Varset('group'),
            shape: ShapeAttr(value:  BasicLineShape(smooth: true)),
              size: SizeAttr(value: 1.5),
            color: ColorAttr(
              variable: 'group',
              values: [
                const Color(0xff5470c6),
                const Color(0xff91cc75),
              ],
            ),
          ),
          PointElement(
            color: ColorAttr(
              variable: 'group',
              values: Defaults.colors10,
              updaters: {
                'groupMouse': {
                  false: (color) => color.withAlpha(100)
                },
                'groupTouch': {
                  false: (color) => color.withAlpha(100)
                },
              },
            ),
          ),
        ],
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
        selections: {
          'tooltipMouse': PointSelection(on: {
            GestureType.hover,
          }, devices: {
            PointerDeviceKind.mouse
          }, variable: 'day', dim: Dim.x),
          'tooltipTouch': PointSelection(on: {
            GestureType.scaleUpdate,
            GestureType.tapDown,
            GestureType.longPressMoveUpdate
          }, devices: {
            PointerDeviceKind.touch
          }, variable: 'day', dim: Dim.x),
        },
        tooltip: TooltipGuide(
          followPointer: [true, true],
          align: Alignment.topLeft,
          variables: ['group', 'value'],
        ),
        crosshair: CrosshairGuide(
          followPointer: [false, true],
        ),
        annotations: [
          MarkAnnotation(
            relativePath: Path()
              ..addRect(Rect.fromCircle(
                  center: const Offset(0, 0), radius: 5)),
            style: Paint()..color = Defaults.colors10[0],
            anchor: (size) =>  Offset(50, size.height-10),
          ),
          TagAnnotation(
            label: Label(
              title1Unit,
              LabelStyle(
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontWeight:FontWeight.bold,
                      decorationStyle: TextDecorationStyle.solid
                  ),
                  align: Alignment.centerRight),
            ),
            anchor: (size) =>  Offset(50+8, size.height-10),
          ),
          MarkAnnotation(
            relativePath: Path()
              ..addRect(Rect.fromCircle(
                  center: const Offset(0, 0), radius: 5)),
            style: Paint()..color = Defaults.colors10[1],
            anchor: (size) => Offset(50 + size.width / 3, size.height-10),

          ),
          TagAnnotation(
            label: Label(
              title2Unit,
                LabelStyle(
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight:FontWeight.bold,
                        decorationStyle: TextDecorationStyle.solid
                    ),
                    align: Alignment.centerRight),
            ),
            anchor: (size) => Offset(34+25 + size.width / 3, size.height-10),
          ),

        ],
      ),
    );
  }

  @override
  void dispose() {
    chartData.clear();
    super.dispose();
  }
}
