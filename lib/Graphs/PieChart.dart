/// Package import
import 'package:circular_clip_route/circular_clip_route.dart';
import 'package:dashboardpoc/Model/dashboard_model.dart';
import 'package:dashboardpoc/Utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

import '../Dashboard/Components/graph_screen.dart';
import '../Dashboard/Components/weather_details.dart';
import '../Model/sample_view.dart';

/// Base class of the sample's stateful widget class
class PieChart extends StatefulWidget {
  PieChart({Key? key, required this.onTap, required this.isHidden}) : super(key: key);
  late VoidCallback onTap;
  late bool isHidden;
  /// base class constructor of sample's stateful widget class
  @override
  _PieChartState createState() => _PieChartState(this.onTap,this.isHidden);

}

class _PieChartState extends State<PieChart> {

  _PieChartState(this.onTap, this.isHidden);
  late VoidCallback onTap;
  late bool isHidden;
  /// Holds the information of current page is card view or not
  late bool isCardView = true;

  List<Map<dynamic,dynamic>> chartData = [];
  String title1Unit = "";
  String value1 = "";
  String titleWithUnit = "";

  final  _avatarKey = GlobalKey();

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
          getRaceChartView(),
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
                                GraphView(titleValue: "Pie Chart"),
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

  Widget getRaceChartView() {
    return Container(
      // margin: const EdgeInsets.only(top: 10),
      child: Chart(
        padding: (_) => const EdgeInsets.fromLTRB(30, 30, 30, 30),
        data: chartData,
        variables: {
          title: Variable(
            accessor: (Map map) => map[title] as String,
          ),
          value1: Variable(
            accessor: (Map map) => map[value1] as num,
            scale: LinearScale(min: 0),
          ),
        },
        elements: [
          IntervalElement(
            label: LabelAttr(
                encoder: (tuple) => Label(
                    tuple[value1].toString()
                )..style =  LabelStyle(
                   style: const TextStyle(
                       color: Colors.black,
                       fontSize: 12.0,
                       fontWeight:FontWeight.bold,
                       decorationStyle: TextDecorationStyle.double
                   ),
                ),
            ),
            color: ColorAttr(
              variable: title,
              values: Defaults.colors10,
            ),
          )
        ],
        // tooltip: TooltipGuide(multiTuples: true),
        // crosshair: CrosshairGuide(),
        coord: PolarCoord(transposed: true),
        axes: [
          Defaults.radialAxis..label = null,
          Defaults.circularAxis
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
        ],
      ),
    );
  }

  Widget getChartView() {

    return Container(
      margin: const EdgeInsets.only(top: 1),
      // width: 350,
      // height: 300,
      child: Chart(
        data: chartData,
        variables: {
          title: Variable(
            accessor: (Map map) => map[title] as String,
          ),
          value: Variable(
            accessor: (Map map) => map[value] as num,
          ),
        },
        transforms: [
          Proportion(
            variable: value,
            as: 'percent',
          )
        ],
        elements: [
          IntervalElement(
            position: Varset('percent') / Varset(title),
            label: LabelAttr(
                encoder: (tuple) => Label(
                  '${tuple[title].toString()}\n${tuple[value].toString()} ${title1Unit.toString()}',
                  LabelStyle(style: Defaults.runeStyle),
                )),
            color: ColorAttr(
                variable: title, values: Defaults.colors10),
            modifiers: [StackModifier()],
          )
        ],
        coord: PolarCoord(transposed: true, dimCount: 1),
      ) ,
    );
  }

  @override
  void dispose() {
    chartData.clear();
    super.dispose();
  }

}


const basicData = [
  {'genre': 'Sports', 'sold': 275},
  {'genre': 'Strategy', 'sold': 115},
  {'genre': 'Action', 'sold': 120},
  {'genre': 'Shooter', 'sold': 350},
  {'genre': 'Other', 'sold': 150},
];