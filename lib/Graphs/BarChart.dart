/// Package import
// import 'dart:ffi';

import 'dart:math';

import 'package:circular_clip_route/circular_clip_route.dart';
import 'package:dashboardpoc/Dashboard/Components/weather_details.dart';
import 'package:dashboardpoc/Model/dashboard_model.dart';
import 'package:dashboardpoc/Utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

import '../Dashboard/Components/graph_screen.dart';

/// Base class of the sample's stateful widget class
class BarChart extends StatefulWidget {
  /// base class constructor of sample's stateful widget class

   BarChart({Key? key, required this.onTap, required this.isHidden}) : super(key: key);

  late VoidCallback onTap;
  late bool isHidden;
  @override
  _BarChartState createState() => _BarChartState(this.onTap, this.isHidden);

}

class _BarChartState extends State<BarChart> {

  _BarChartState(this.onTap, this.isHidden);

  /// Holds the information of current page is card view or not
  late bool isCardView = false;



  String title1Unit = "";
  String title2Unit = "";

  late VoidCallback onTap;
  late bool isHidden;

  List<Map<dynamic,dynamic>> chartData = [];

  final  _avatarKey = GlobalKey();

  @override
  void initState() {

    readJson();

    super.initState();
  }


  void readJson()  {

    // List<Map<dynamic,dynamic>> readJson()  {
    for(int i=0; i<(model.weeklyData ?? []).length; i++) {
      var y1Value = double.parse((model.weeklyData![i].value1 ?? "").replaceAll(",", ""));
      var y2Value = double.parse((model.weeklyData![i].value2 ?? "").replaceAll(",", ""));
      // Map formData = {title:model.weeklyData![i].value, value: yValue};
      // Map formData1 = {"type":model.weeklyData![i].title1, "index": i, "value":y1Value};
      // Map formData2 = {"type":model.weeklyData![i].title2, "index": i, "value":y2Value};

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
    //return _buildDefaultColumnChart();

    // var screenSize = MediaQuery.of(context).size ;
    // print('Bar chart: $screenSize ');

    return SizedBox(
      key: _avatarKey,
       // height: screenSize.height - 100,
      child: Stack(
        children: [

          getChartView(context),
          // getChartViewtest(),

        Visibility(
          visible: this.isHidden,
            child: Positioned(
                right: 0.0,
                top: 0.0,
                child: SizedBox(
                  width: 30, // Adjust width and/or height of sized box to control button size
                  child: FloatingActionButton(
                    child: Image.asset( 'assets/images/expand.png',
                      height: 25
                    ),
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    onPressed: () {
                      // print('printed barchart');
                      Navigator.push(
                        contextLocal,
                        CircularClipRoute<void>(
                          builder: (context) =>
                              GraphView(titleValue: "Bar Chart"),
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

          // _buildDefaultBarChart(),
          // DelayedDisplay(
          //   delay: const Duration(seconds: 2),
          //     child: _buildDefaultBarChart(),
          // ),
        ],
      ),
    );
  }

  Widget getChartView(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(top: 1),
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
                formatter:(v) => '${StrIntCurrency().intToStringID(v.toInt())}  '//v.toInt()
            ),
          ),
        },
        elements: [
          IntervalElement(
            position:
            Varset('index') * Varset('value') / Varset('type'),
            color: ColorAttr(
                variable: 'type', values: Defaults.colors10),
            size: SizeAttr(value: 2),
            // modifiers: [DodgeModifier(ratio: 0.1)],
            modifiers: [DodgeSizeModifier()],
            // layer: 4
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
                  align: Alignment.centerRight,
              ),
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
                  align: Alignment.centerRight
              ),
            ),
            anchor: (size) => Offset(34 +25 + size.width / 3, size.height-10),
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



const _kBaseGroupPaddingHorizontal = 32.0;
const _kMinBarSize = 4.0;

/// Changes the position of elements while also updating their width to match
/// the number of elements in a single band. Useful for bar charts when the
/// width of the bars can be dynamic.
@immutable
class DodgeSizeModifier extends Modifier {
  @override
  void modify(AesGroups groups, Map<String, ScaleConv<dynamic, num>> scales,
      AlgForm form, CoordConv coord, Offset origin) {
    final xField = form.first[0];
    final band = (scales[xField]! as DiscreteScaleConv).band;

    final ratio = 1 / groups.length;
    final numGroups = groups.length;
    final groupHorizontalPadding = _kBaseGroupPaddingHorizontal / numGroups;
    final invertedGroupPaddingHorizontal =
    coord.invertDistance(groupHorizontalPadding, Dim.x);

    final effectiveBand = band - 1.5 * invertedGroupPaddingHorizontal;

    final maxWidth = coord.convert(const Offset(1, 0)).dx;
    final maxWidthInBand = effectiveBand * maxWidth;
    final maxWidthPerAes = maxWidthInBand / numGroups;
    final barHorizontalPadding = groupHorizontalPadding / 2;
    final size = max(maxWidthPerAes - barHorizontalPadding, _kMinBarSize);

    final bias = ratio * effectiveBand;

    // Negatively shift half of the total bias.
    var accumulated = -bias * (numGroups + 1) / 2;

    for (final group in groups) {
      for (final aes in group) {
        final oldPosition = aes.position;
        aes.position = oldPosition
            .map(
              (point) => Offset(point.dx + accumulated + bias, point.dy),
        )
            .toList();

        aes.size = size;
      }
      accumulated += bias;
    }
  }

  @override
  bool equalTo(Object other) {
    return super == other;
  }
}


const adjustData = [
  {"type": "Email", "index": 0, "value": 120},
  {"type": "Email", "index": 1, "value": 132},
  {"type": "Email", "index": 2, "value": 101},
  {"type": "Email", "index": 3, "value": 134},
  {"type": "Email", "index": 4, "value": 90},
  {"type": "Email", "index": 5, "value": 230},
  {"type": "Email", "index": 6, "value": 210},
  {"type": "Affiliate", "index": 0, "value": 220},
  {"type": "Affiliate", "index": 1, "value": 182},
  {"type": "Affiliate", "index": 2, "value": 191},
  {"type": "Affiliate", "index": 3, "value": 234},
  {"type": "Affiliate", "index": 4, "value": 290},
  {"type": "Affiliate", "index": 5, "value": 330},
  {"type": "Affiliate", "index": 6, "value": 310},
  {"type": "Video", "index": 0, "value": 150},
  {"type": "Video", "index": 1, "value": 232},
  {"type": "Video", "index": 2, "value": 201},
  {"type": "Video", "index": 3, "value": 154},
  {"type": "Video", "index": 4, "value": 190},
  {"type": "Video", "index": 5, "value": 330},
  {"type": "Video", "index": 6, "value": 410},
  {"type": "Direct", "index": 0, "value": 320},
  {"type": "Direct", "index": 1, "value": 332},
  {"type": "Direct", "index": 2, "value": 301},
  {"type": "Direct", "index": 3, "value": 334},
  {"type": "Direct", "index": 4, "value": 390},
  {"type": "Direct", "index": 5, "value": 330},
  {"type": "Direct", "index": 6, "value": 320},
  {"type": "Search", "index": 0, "value": 320},
  {"type": "Search", "index": 1, "value": 432},
  {"type": "Search", "index": 2, "value": 401},
  {"type": "Search", "index": 3, "value": 434},
  {"type": "Search", "index": 4, "value": 390},
  {"type": "Search", "index": 5, "value": 430},
  {"type": "Search", "index": 6, "value": 420},
];


