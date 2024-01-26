
import 'package:dashboardpoc/Dashboard/Components/recent_files.dart';
import 'package:dashboardpoc/Gauges/LinearGauge.dart';
import 'package:dashboardpoc/Graphs/BarChart.dart';
import 'package:dashboardpoc/Graphs/ColumnChart.dart';
import 'package:dashboardpoc/Graphs/FinancialChart.dart';
import 'package:dashboardpoc/Graphs/Histogram.dart';
import 'package:dashboardpoc/Graphs/LineChart.dart';
import 'package:dashboardpoc/Graphs/PieChart.dart';
import 'package:dashboardpoc/Graphs/StackedBarChart.dart';
import 'package:dashboardpoc/Graphs/StackedLineChart.dart';
import 'package:dashboardpoc/Graphs/StepArea.dart';
import 'package:dashboardpoc/Utilities/constants.dart';
import 'package:flutter/material.dart';
import 'dart:math';


class GraphView extends StatefulWidget {
  // const GraphView({Key? key}) : super(key: key);

  GraphView(
      {Key? key, required this.titleValue}) : super(key: key);

  final String titleValue ;

  @override
  _GraphViewState createState() => _GraphViewState(titleValue: titleValue);
}

class _GraphViewState extends State<GraphView> {

  _GraphViewState(
      {required this.titleValue});

  final String titleValue ;

  Widget _listItem(index) {

    String indexValue = index;
    if (indexValue == "Bar Chart") {
        return BarChart(onTap: () {  }, isHidden: false,);
        // return HistogramChart(onTap: () {  }, isHidden: false,);
    } else if (indexValue == "Column Chart") {
      return ColumnChart(onTap: () {  }, isHidden: false,);
    } else if (indexValue == "Line Chart") {
      return LineChart(onTap: () {  }, isHidden: false,);
    } else if (indexValue == "Financial Chart") {
      return FinancialChart(onTap: () {  }, isHidden: false,);
    } else if (indexValue == "StackedBar Chart") {
      return StackedBarChart(onTap: () {  }, isHidden: false,);
    } else if (indexValue == "StackedLine Chart") {
      return StackedLineChart(onTap: () {  }, isHidden: false,);
    } else if (indexValue == "StepArea Chart") {
      return StepAreaChart(onTap: () {  }, isHidden: false,);
    } else if (indexValue == "Pie Chart") {
      return PieChart(onTap: () {  }, isHidden: false,);
    } else {
      return Container(
        child: Text(indexValue),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(titleValue),
          flexibleSpace: Container(
            decoration:BoxDecoration(
          gradient:colorclass.gradientValue,
            )
          ),
        ),
        body: Stack(
            children:<Widget> [
        Column(
        children: <Widget>[
            Expanded(
            // flex:6,
              child:
              Container(

                height: screenheight-200,
                  padding: const EdgeInsets.all(5.0),
                  // decoration:BoxDecoration(
                  //     gradient:colorclass.graphviewValue,
                  //     boxShadow: [
                  //       colorclass.shadowView,
                  //     ]
                  // ),
                  child: _listItem(titleValue)
              ),
            ),
          // Expanded(
          //
          //     child:
              Container(
                 height: 300,
                padding:const EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
                child:RecentFiles(),
              ),
          // )
          ]
        )
        ]
        ),
    );
  }
}