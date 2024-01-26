/// Package import
import 'package:dashboardpoc/Model/dashboard_model.dart';
import 'package:dashboardpoc/Utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';


/// Base class of the sample's stateful widget class
class HistogramChart extends StatefulWidget {
  /// base class constructor of sample's stateful widget class

  HistogramChart({Key? key, required this.onTap, required this.isHidden}) : super(key: key);
  late VoidCallback onTap;
  late bool isHidden;
  @override
  _HistogramChartState createState() => _HistogramChartState(this.onTap,this.isHidden);

}

class _HistogramChartState extends State<HistogramChart> {

  _HistogramChartState(this.onTap, this.isHidden);

  late VoidCallback onTap;
  late bool isHidden;
  /// Holds the information of current page is card view or not
  late bool isCardView = false;


  List<Map<dynamic,dynamic>> chartData = [];

  String title1Unit = "";
  String title2Unit = "";

  double finalMaxVal = 0.0;
  double finalMinVal = 0.0;

  @override
  void initState() {

    readJson();
    super.initState();
  }

  void readJson()  {
    List<double> maxValues =[];
    for(int i=0; i<(model.weeklyData ?? []).length; i++) {
      var y1Value = double.parse((model.weeklyData![i].value1 ?? "").replaceAll(",", ""));
      var y2Value = double.parse((model.weeklyData![i].value2 ?? "").replaceAll(",", ""));
      var y3Value = double.parse((model.weeklyData![i].value3 ?? "").replaceAll(",", ""));
      maxValues.add(y1Value);
      maxValues.add(y2Value);
      maxValues.add(y3Value);
      if ((model.weeklyData![i].value3 ?? "").isNotEmpty) {
        var y4Value = double.parse((model.weeklyData![i].value4 ?? "").replaceAll(",", ""));
        maxValues.add(y4Value);
      }
    }
    double maxVal = maxValues.reduce((value, element) => value > element ? value: element);
    double perVal = maxVal*0.8;

    finalMaxVal = maxVal + perVal ;
    // List<Map<dynamic,dynamic>> readJson()  {



    for(int i=0; i<(model.weeklyData ?? []).length; i++) {


      var yValue = double.parse((model.weeklyData![i].value1 ?? "").replaceAll(",", ""));
      Map formData = {"genre":model.weeklyData![i].value, "sold": yValue, 'title':'${model.weeklyData![0].title1 ?? ""}(${model.weeklyData![0].title1Unit ?? ""})'};
      chartData.add(formData);
    }
    // return chartData;
  }

  @override
  Widget build(BuildContext context) {
    //return _buildDefaultColumnChart();
    return SizedBox(
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

  Widget getChartView() {

    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: 600,
      // height: 300,
      child: Chart(
        padding: (_) => const EdgeInsets.all(10),
        data: chartData,
        variables: {
          'genre': Variable(
            accessor: (Map map) => map['genre'] as String,
          ),
          'sold': Variable(
            accessor: (Map map) => map['sold'] as num,
            scale: LinearScale(min: -200, max: 250),
          ),
        },
        transforms: [
          Sort(
            compare: (a, b) =>
                ((b['sold'] as num) - (a['sold'] as num)).toInt(),
          )
        ],
        elements: [
          IntervalElement(
            label: LabelAttr(
                encoder: (tuple) => Label(
                  '${tuple['genre'].toString()}\ntemparature:${tuple['sold'].toString()}',
                  LabelStyle(style: Defaults.runeStyle),
                )),
            shape: ShapeAttr(value: FunnelShape()),
            color: ColorAttr(
                variable: 'genre', values: Defaults.colors10),
            modifiers: [SymmetricModifier()],
          )
        ],
        coord: RectCoord(transposed: true, verticalRange: [1, 0]),
      ),
    );
  }

}

