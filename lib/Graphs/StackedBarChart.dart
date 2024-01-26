/// Package import
import 'package:circular_clip_route/circular_clip_route.dart';
import 'package:dashboardpoc/Model/dashboard_model.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import '../Dashboard/Components/graph_screen.dart';
import '../Dashboard/Components/weather_details.dart';
import '../Model/sample_view.dart';
import '../Utilities/constants.dart';


/// Base class of the sample's stateful widget class
class StackedBarChart extends StatefulWidget {
  /// base class constructor of sample's stateful widget class
  StackedBarChart({Key? key, required this.onTap, required this.isHidden}) : super(key: key);
  late VoidCallback onTap;
  late bool isHidden;
  @override
  _StackedBarChartState createState() => _StackedBarChartState(this.onTap, this.isHidden);

}

class _StackedBarChartState extends State<StackedBarChart> {

  _StackedBarChartState(this.onTap, this.isHidden);
  late VoidCallback onTap;
  late bool isHidden;

  /// Holds the information of current page is card view or not
  late bool isCardView = false;

  List<Map<dynamic,dynamic>> chartData = [];

  String title1Unit = "";
  String title2Unit = "";

  double finalVal = 0.0;
  double finalMinVal = 0.0;

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

    finalVal = maxVal + perVal ;

    double minVal = maxValues.reduce((value, element) => value < element ? value: element);
    double minPerVal = minVal*0.4;

    finalMinVal = minPerVal + minVal;

    if (finalMinVal >0){
      finalMinVal = 0.0;
    }

    for(int i=0; i<(model.weeklyData ?? []).length; i++) {

      var y1Value = double.parse((model.weeklyData![i].value1 ?? "").replaceAll(",", ""));
      var y2Value = double.parse((model.weeklyData![i].value2 ?? "").replaceAll(",", ""));

      // Map formData1 = {"type":'${model.weeklyData![0].value ?? ""}\n${model.weeklyData![0].title1 ?? ""}(${model.weeklyData![0].title1Unit ?? ""})', "index": i, "value":y1Value,"xvalue":model.weeklyData![i].value};
      // Map formData2 = {"type":'${model.weeklyData![0].title2 ?? ""}(${model.weeklyData![0].title2Unit ?? ""})', "index": i, "value":y2Value,"xvalue":model.weeklyData![i].value};

      Map formData1 = {"type":'${model.weeklyData![0].title1 ?? ""}(${model.weeklyData![0].title1Unit ?? ""})', "value":y1Value,"index":model.weeklyData![i].value};
      Map formData2 = {"type":'${model.weeklyData![0].title2 ?? ""}(${model.weeklyData![0].title2Unit ?? ""})', "value":y2Value,"index":model.weeklyData![i].value};


      chartData.add(formData1);
      chartData.add(formData2);

    }
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
                                GraphView(titleValue: "StackedBar Chart"),
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
    );;
  }

  Widget getChartView() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      // width: 350,
      // height: 300,
      child: Chart(
        padding: (_) => const EdgeInsets.fromLTRB(30, 5, 10, 100),
        data: chartData,
        variables: {
          'index': Variable(
            accessor: (Map map) => map['index'].toString(),
            // scale: OrdinalScale(tickCount: 4),
          ),
          'type': Variable(
            accessor: (Map map) => map['type'] as String,
          ),
          'value': Variable(
            accessor: (Map map) => map['value'] as num,
            scale: LinearScale(
                min: finalMinVal,
                max: finalVal,
                formatter:(v) => '${StrIntCurrency().intToStringID(v.toInt())}    '
            ),
          ),
        },
        elements: [
          IntervalElement(
            position:
            Varset('index') * Varset('value') / Varset('type'),
            shape: ShapeAttr(value: RectShape(labelPosition: 0.5)),
            color: ColorAttr(
                variable: 'type', values: Defaults.colors10),
            label: LabelAttr(
                encoder: (tuple) => Label(
                  tuple['value'].toString(),
                  LabelStyle(style: const TextStyle(fontSize: 6)),
                )),
            modifiers: [StackModifier()],
          )
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
          'tap': PointSelection(
            variable: 'index',
          )
        },
        tooltip: TooltipGuide(multiTuples: true),
        crosshair: CrosshairGuide(),
        annotations: [
          MarkAnnotation(
            relativePath: Path()
              ..addRect(Rect.fromCircle(
                  center: const Offset(0, 0), radius: 5)),
            style: Paint()..color = Defaults.colors10[0],
            anchor: (size) =>  Offset(25, size.height-10),
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
            anchor: (size) =>  Offset(25+8, size.height-10),
          ),
          MarkAnnotation(
            relativePath: Path()
              ..addRect(Rect.fromCircle(
                  center: const Offset(0, 0), radius: 5)),
            style: Paint()..color = Defaults.colors10[1],
            anchor: (size) => Offset(25 + size.width / 3, size.height-10),

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
            anchor: (size) => Offset(34 + size.width / 3, size.height-10),
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

