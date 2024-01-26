/// Package import
import 'package:dashboardpoc/Model/dashboard_model.dart';
import 'package:dashboardpoc/Utilities/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';



/// Base class of the sample's stateful widget class 
class LineChart extends StatefulWidget {
  /// base class constructor of sample's stateful widget class
  LineChart({Key? key, required this.onTap, required this.isHidden}) : super(key: key);
  late VoidCallback onTap;
  late bool isHidden;
  @override
  _LineChartState createState() => _LineChartState(this.onTap, this.isHidden);
 
}

class _LineChartState extends State<LineChart> {

  _LineChartState(this.onTap, this.isHidden);
  late VoidCallback onTap;
  late bool isHidden;

  // List<_ChartData>? chartData = <_ChartData>[];
  List<Map<dynamic,dynamic>> chartData = [];

  /// Holds the information of current page is card view or not
  late bool isCardView = false;

  double finalMaxVal = 0.0;
  double finalMinVal = 0.0;

  String title1Unit = "";
  String unitValue = "";

  @override
  void initState() {

    // chartData = [];
    // for(int i=0; i<model.weeklyData!.length; i++){
    //   var yValue = double.parse((model.weeklyData![i].value1 ?? "").replaceAll(",", ""));
    //   var yValue1 = double.parse((model.weeklyData![i].value2 ?? "").replaceAll(",", ""));
    //   // assert(yValue is double);
    //   String string = '${model.weeklyData![i].value}';
    //   string = string.replaceAll("-", "/");  // strang
    //   string = string.replaceAll("2022", "22");
    //
    //   _ChartData chartDataInternal = _ChartData(string, yValue, yValue1,(model.weeklyData![i].title1Unit ?? ""),model.weeklyData![i].title2Unit ?? "",model.weeklyData![i].title ?? "",model.weeklyData![i].title1 ?? "", model.weeklyData![i].title2 ?? "");
    //   //ChartSampleData(x: model.weeklyData![i].date, y: yValue);
    //   chartData?.add(chartDataInternal);
    // }
    readJson();
    super.initState();
  }

  void readJson()  {
    // List<Map<dynamic,dynamic>> readJson()  {

    List<double> maxValues =[];
    for(int i=0; i<(model.weeklyData ?? []).length; i++) {
      var y2Value = double.parse((model.weeklyData![i].value1 ?? "").replaceAll(",", ""));
      maxValues.add(y2Value);
    }
    double maxVal = maxValues.reduce((value, element) => value > element ? value: element);
    double perVal = maxVal*0.5;
    finalMaxVal = maxVal + perVal;

    for(int i=0; i<(model.weeklyData ?? []).length; i++) {
      var y1Value = double.parse((model.weeklyData![i].value1 ?? "").replaceAll(",", ""));
      // var y2Value = double.parse((model.weeklyData![i].value2 ?? "").replaceAll(",", ""));

      Map formData1 = {"day":'${model.weeklyData![i].value ?? ""}', "value":y1Value,'title': 'Highest', "group":'${model.weeklyData![0].title1 ?? ""}(${model.weeklyData![0].title1Unit ?? ""})'};
      // Map formData2 = {"day":'${model.weeklyData![i].value ?? ""}', "value":y2Value,'title': 'Lowest', "group":'${model.weeklyData![0].title2 ?? ""}(${model.weeklyData![0].title2Unit ?? ""})'};
      chartData.add(formData1);
      // chartData.add(formData2);
    }
    // print(chartData);
    title1Unit = '${model.weeklyData![0].title1 ?? ""}(${model.weeklyData![0].title1Unit ?? ""})';
    unitValue = '${model.weeklyData![0].title1Unit ?? ""}';
    // return chartData;
  }

  @override
  Widget build(BuildContext context) {
    // return _buildDefaultLineChart();
    return SizedBox(
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
                        // print('printed barchart');
                        onTap();
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
        data: chartData,
        variables: {
          'day': Variable(
            accessor: (Map datum) => datum['day'] as String,
            scale: OrdinalScale(
                tickCount: 4,
              formatter: (v) => ' ${v}'
            ),
          ),
          'value': Variable(
            accessor: (Map datum) => datum['value'] as num,
            scale: LinearScale(
              max: finalMaxVal,
              min: finalMinVal,
              tickCount: 7,
               formatter: (v) => '${StrIntCurrency().intToStringID(v.toInt())}    ',
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
            color: ColorAttr(
              variable: 'group',
              values: [
                const Color(0xff5470c6),
                const Color(0xff91cc75),
              ],
            ),
          ),
        ],
        axes: [
          // Defaults.horizontalAxis,
          // Defaults.verticalAxis,
          Defaults.horizontalAxis
            ..tickLine = TickLine()
            ..line = StrokeStyle(
                width: 1.0,
                color: Colors.black45
            )
            ..label = LabelStyle(
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12.0
                )
            ),
          Defaults.verticalAxis
            ..line = StrokeStyle(
                width: 1.0,
                color: Colors.black45
            )
            ..label = LabelStyle(
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12.0
                )
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
           ..addRect(Rect.fromCircle(center: const Offset(0, 0), radius: 5)),
            style: Paint()..color = Defaults.colors10[0],
            anchor: (size) => const Offset(50, 3),
            ),
            TagAnnotation(
            label: Label(
              title1Unit,
            LabelStyle(
            style: Defaults.textStyle,
            align: Alignment.centerRight),
            ),
            anchor: (size) => const Offset(50+8, 3),
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

