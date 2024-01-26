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
class ColumnChart extends StatefulWidget {
  /// base class constructor of sample's stateful widget class
   ColumnChart({Key? key, required this.onTap, required this.isHidden}) : super(key: key);
  late VoidCallback onTap;
  late bool isHidden;
  @override
  _ColumnChartState createState() => _ColumnChartState(this.onTap, this.isHidden);
}

class _ColumnChartState extends State<ColumnChart> {

  _ColumnChartState(this.onTap, this.isHidden);

  late VoidCallback onTap;
  late bool isHidden;
  /// Holds the information of current page is card view or not
  late bool isCardView = false;
  final  _avatarKey = GlobalKey();

  List<Map<dynamic,dynamic>> chartData = [];

  String title1Unit = "";
  String value1 = "";
  String titleWithUnit = "";

  @override
  void initState() {

    readJson();
    super.initState();
  }

  void readJson()  {
    // List<Map<dynamic,dynamic>> readJson()  {
    for(int i=0; i<(model.weeklyData ?? []).length; i++) {
      var yValue = double.parse((model.weeklyData![i].value1 ?? "").replaceAll(",", ""));
      Map formData = {title:model.weeklyData![i].value, "${model.weeklyData![i].title1}": yValue};
      chartData.add(formData);
    }
    value1 = model.weeklyData![0].title1 ?? "";
    title1Unit = model.weeklyData![0].title1Unit ?? "";
    titleWithUnit = '${value1}(${title1Unit})';
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
                                GraphView(titleValue: "Column Chart"),
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
      margin: const EdgeInsets.only(top: 1),
      //  width: 250,
      // height: 600,
      child: Chart(
        padding: (_) => const EdgeInsets.fromLTRB(70, 5, 10, 40),
        data: chartData,
        variables: {
          title: Variable(
            accessor: (Map map) => map[title] as String,
            scale: OrdinalScale(
              formatter: (v) => '${v}  '
            )
          ),
          value1: Variable(
            accessor: (Map map) => map[value1] as num,
            scale: LinearScale(
                formatter:(v) => '${StrIntCurrency().intToStringID(v.toInt())} ${title1Unit}'//v.toInt()
            ),
          )
        },
        elements: [
          IntervalElement(
            // label: LabelAttr(
            //     encoder: (tuple) => Label(tuple['sold'].toString())),
            gradient: GradientAttr(
                value: const LinearGradient(colors: [
                  // Color(0x8883bff6),
                  // Color(0x88188df0),
                  Color(0xcc188df0),
                ], stops: [
                  // 0,
                  // 0.5,
                  1
                ]),
                updaters: {
                  'tap': {
                    true: (_) => const LinearGradient(colors: [
                      Color(0xee83bff6),
                      Color(0xee3f78f7),
                      Color(0xff3f78f7),
                    ], stops: [
                      0,
                      0.7,
                      1
                    ])
                  }
                }),
          )
        ],
        coord: RectCoord(transposed: true),
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
              // rotation: 175.0,
              // // minWidth: 150.0,
              // align: const Alignment(-1.2,1.0),
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
              align: const Alignment(0,1.5),
            ),
        ],

        selections: {'tap': PointSelection(dim: Dim.x)},
        tooltip: TooltipGuide(
          // anchor: (_) => Offset.zero,
          align: Alignment.center,
          // selections: "1",
        ),
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
              titleWithUnit,
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

