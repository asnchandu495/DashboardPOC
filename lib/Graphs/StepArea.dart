/// Package import
import 'package:dashboardpoc/Dashboard/Components/weather_details.dart';
import 'package:dashboardpoc/Model/dashboard_model.dart';
import 'package:dashboardpoc/Utilities/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

import '../Dashboard/Components/graph_screen.dart';

import 'package:circular_clip_route/circular_clip_route.dart';



/// Base class of the sample's stateful widget class
class StepAreaChart extends StatefulWidget {
  /// base class constructor of sample's stateful widget class
  StepAreaChart({Key? key, required this.onTap, required this.isHidden}) : super(key: key);
  late VoidCallback onTap;
  late bool isHidden;
  @override
  _StepAreaChartState createState() => _StepAreaChartState(this.onTap,this.isHidden);
}

class _StepAreaChartState extends State<StepAreaChart> {

  _StepAreaChartState(this.onTap, this.isHidden);
  late VoidCallback onTap;
  late bool isHidden;

  /// Holds the information of current page is card view or not
  late bool isCardView = false;
  List<Map<dynamic,dynamic>> chartData = [];

  String title1Unit = "";
  String title2Unit = "";
  String title3Unit = "";
  String title4Unit = "";

  double finalMaxVal = 0.0;
  double finalMinVal = 0.0;

  final  _avatarKey = GlobalKey();

  @override
  void initState() {
    this.readJson();
    super.initState();
  }

  void readJson()  {
    // List<Map<dynamic,dynamic>> readJson()  {
    List<double> maxValues =[];
    for(int i=0; i<(model.weeklyData ?? []).length; i++) {
      var y1Value = double.parse((model.weeklyData![i].value1 ?? "").replaceAll(",", ""));
      var y2Value = double.parse((model.weeklyData![i].value2 ?? "").replaceAll(",", ""));
      var y3Value = double.parse((model.weeklyData![i].value3 ?? "").replaceAll(",", ""));
      maxValues.add(y1Value);
      maxValues.add(y2Value);
      maxValues.add(y3Value);

      if ((model.weeklyData![i].value4 ?? "").isNotEmpty) {
        var y4Value = double.parse((model.weeklyData![i].value4 ?? "").replaceAll(",", ""));
        maxValues.add(y4Value);
      }
    }
    double maxVal = maxValues.reduce((value, element) => value > element ? value: element);
    double perVal = maxVal*0.1;

    finalMaxVal = maxVal + perVal ;

    double minVal = maxValues.reduce((value, element) => value < element ? value: element);
    double minPerVal = minVal*0.4;

    finalMinVal = minPerVal + minVal;

    if (finalMinVal >0){
      finalMinVal = 0.0;
    }

    for(int i=0; i<(model.weeklyData ?? []).length; i++) {
      var y1Value = double.parse((model.weeklyData![i].value1 ?? "").replaceAll(",", ""));
      var y2Value = double.parse((model.weeklyData![i].value2 ?? "").replaceAll(",", ""));
      var y3Value = double.parse((model.weeklyData![i].value3 ?? "").replaceAll(",", ""));

      Map formData1 = {"day":'${model.weeklyData![i].value ?? ""}', "value":y1Value, "group":'${model.weeklyData![0].title1 ?? ""}(${model.weeklyData![0].title1Unit ?? ""})'};
      Map formData2 = {"day":'${model.weeklyData![i].value ?? ""}', "value":y2Value, "group":'${model.weeklyData![0].title2 ?? ""}(${model.weeklyData![0].title2Unit ?? ""})'};
      Map formData3 = {"day":'${model.weeklyData![i].value ?? ""}', "value":y3Value, "group":'${model.weeklyData![0].title3 ?? ""}(${model.weeklyData![0].title3Unit ?? ""})'};

      chartData.add(formData1);
      chartData.add(formData2);
      chartData.add(formData3);

      if ((model.weeklyData![i].value4 ?? "").isNotEmpty) {
        var y4Value = double.parse((model.weeklyData![i].value4 ?? "").replaceAll(",", ""));
        Map formData4 = {"day":model.weeklyData![i].value ?? "", "value":y4Value, "group":'${model.weeklyData![0].title4 ?? ""}(${model.weeklyData![0].title4Unit ?? ""})'};
        chartData.add(formData4);
      }
    }

    // print(chartData);
    title1Unit = '${model.weeklyData![0].title1 ?? ""}(${model.weeklyData![0].title1Unit ?? ""})';
    title2Unit = '${model.weeklyData![0].title2 ?? ""}(${model.weeklyData![0].title2Unit ?? ""})';
    title3Unit = '${model.weeklyData![0].title3 ?? ""}(${model.weeklyData![0].title3Unit ?? ""})';
    if ((model.weeklyData![0].value4 ?? "").isNotEmpty) {
      title4Unit =
      '${model.weeklyData![0].title4 ?? ""}(${model.weeklyData![0].title4Unit ?? ""})';
    }
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
          _buildStepAreaChart(),
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
                                GraphView(titleValue: "StepArea Chart"),
                            expandFrom: _avatarKey.currentContext!,
                            curve: Curves.easeInExpo,
                            reverseCurve: Curves.easeInCirc,
                            opacity: ConstantTween(1),
                            transitionDuration: const Duration(milliseconds: durationAnimation),
                          ),
                          // MaterialPageRoute(
                          //   builder: (context) => GraphView(titleValue: "StepArea Chart"),
                          // ),
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

  /// Returns the cartesian step area chart.
  Widget _buildStepAreaChart() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      // width: 350,
      // height: 300,
      child: Chart(
        padding: (_) => const EdgeInsets.fromLTRB(35, 5, 10, 100),
        data: chartData,
        variables: {
          'day': Variable(
            accessor: (Map datum) => datum['day'] as String,
            // scale: OrdinalScale(inflate: true),
            // scale: OrdinalScale(tickCount: 4),
          ),
          'value': Variable(
            accessor: (Map datum) => datum['value'] as num,
            scale: LinearScale(min: finalMinVal, max: finalMaxVal),
          ),
          'group': Variable(
            accessor: (Map datum) => datum['group'].toString(),
          ),
        },
        elements: [
          AreaElement(
            position:
            Varset('day') * Varset('value') / Varset('group'),
            shape: ShapeAttr(value: BasicAreaShape(smooth: true)),
            gradient: GradientAttr(
              variable: 'group',
              values: [
                const LinearGradient(
                  begin: Alignment(0, 0),
                  end: Alignment(0, 1),
                  colors: [
                    Color.fromARGB(204, 128, 255, 165),
                    Color.fromARGB(204, 1, 191, 236),
                  ],
                ),
                const LinearGradient(
                  begin: Alignment(0, 0),
                  end: Alignment(0, 1),
                  colors: [
                    Color.fromARGB(204, 0, 221, 255),
                    Color.fromARGB(204, 77, 119, 255),
                  ],
                ),
                const LinearGradient(
                  begin: Alignment(0, 0),
                  end: Alignment(0, 1),
                  colors: [
                    Color.fromARGB(204, 55, 162, 255),
                    Color.fromARGB(204, 116, 21, 219),
                  ],
                ),
                const LinearGradient(
                  begin: Alignment(0, 0),
                  end: Alignment(0, 1),
                  colors: [
                    Color.fromARGB(204, 255, 0, 135),
                    Color.fromARGB(204, 135, 0, 157),
                  ],
                ),
                const LinearGradient(
                  begin: Alignment(0, 0),
                  end: Alignment(0, 1),
                  colors: [
                    Color.fromARGB(204, 255, 191, 0),
                    Color.fromARGB(204, 224, 62, 76),
                  ],
                ),
              ],
              updaters: {
                'groupMouse': {
                  false: (gradient) => LinearGradient(
                    begin: const Alignment(0, 0),
                    end: const Alignment(0, 1),
                    colors: [
                      gradient.colors.first.withAlpha(25),
                      gradient.colors.last.withAlpha(25),
                    ],
                  ),
                },
                'groupTouch': {
                  false: (gradient) => LinearGradient(
                    begin: const Alignment(0, 0),
                    end: const Alignment(0, 1),
                    colors: [
                      gradient.colors.first.withAlpha(25),
                      gradient.colors.last.withAlpha(25),
                    ],
                  ),
                },
              },
            ),
            // modifiers: [StackModifier()],
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
              align: const Alignment(-1.5,0),
            ),
        ],
        selections: {
          'tooltipMouse': PointSelection(on: {
            GestureType.hover,
          }, devices: {
            PointerDeviceKind.mouse
          }, variable: 'day'),
          'groupMouse': PointSelection(
              on: {
                GestureType.hover,
              },
              variable: 'group',
              devices: {PointerDeviceKind.mouse}),
          'tooltipTouch': PointSelection(on: {
            GestureType.scaleUpdate,
            GestureType.tapDown,
            GestureType.longPressMoveUpdate
          }, devices: {
            PointerDeviceKind.touch
          }, variable: 'day'),
          'groupTouch': PointSelection(
              on: {
                GestureType.scaleUpdate,
                GestureType.tapDown,
                GestureType.longPressMoveUpdate
              },
              variable: 'group',
              devices: {PointerDeviceKind.touch}),
        },
        tooltip: TooltipGuide(
          selections: {'tooltipTouch', 'tooltipMouse'},
          followPointer: [true, true],
          align: Alignment.topLeft,
        ),
        crosshair: CrosshairGuide(
          selections: {'tooltipTouch', 'tooltipMouse'},
          followPointer: [true, true],
        ),
        annotations: [
          MarkAnnotation(
            relativePath: Path()
              ..addRect(Rect.fromCircle(
                  center: const Offset(0, 0), radius: 5)),
            style: Paint()..color =  const Color.fromARGB(204, 128, 255, 165),//Defaults.colors10[0],
            anchor: (size) =>  Offset(50, size.height-20),
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
                align: Alignment.centerRight,
              ),
            ),
            anchor: (size) =>  Offset(50+8, size.height-20),
          ),
          MarkAnnotation(
            relativePath: Path()
              ..addRect(Rect.fromCircle(
                  center: const Offset(0, 0), radius: 5)),
            style: Paint()..color = const Color.fromARGB(204, 0, 221, 255),
            anchor: (size) => Offset(50 + size.width / 3, size.height-20),

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
                  align: Alignment.centerRight
              ),
            ),
            anchor: (size) => Offset(34 +25 + size.width / 3, size.height-20),
          ),
          MarkAnnotation(
            relativePath: Path()
              ..addRect(Rect.fromCircle(
                  center: const Offset(0, 0), radius: 5)),
            style: Paint()..color = const Color.fromARGB(204, 55, 162, 255),
            anchor: (size) =>  Offset(50, size.height-5),
          ),
          TagAnnotation(
            label: Label(
              title3Unit,
              LabelStyle(
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight:FontWeight.bold,
                    decorationStyle: TextDecorationStyle.solid
                ),
                align: Alignment.centerRight,
              ),
            ),
            anchor: (size) =>  Offset(50+8, size.height-5),
          ),
          MarkAnnotation(
            relativePath: Path()
              ..addRect(Rect.fromCircle(
                  center: const Offset(0, 0), radius: 5)),
            style: Paint()..color = const Color.fromARGB(204, 255, 0, 135),
            anchor: (size) => Offset(50 + size.width / 3, size.height-5),
          ),
          TagAnnotation(
            label: Label(
              title4Unit,
              LabelStyle(
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontWeight:FontWeight.bold,
                      decorationStyle: TextDecorationStyle.solid
                  ),
                  align: Alignment.centerRight
              ),
            ),
            anchor: (size) => Offset(34 +25 + size.width / 3, size.height-5),
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




