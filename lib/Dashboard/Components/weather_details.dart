import 'package:circular_clip_route/circular_clip_route.dart';

import 'package:dashboardpoc/Dashboard/Components/graph_screen.dart';
import 'package:dashboardpoc/Graphs/BarChart.dart';
import 'package:dashboardpoc/Graphs/ColumnChart.dart';
import 'package:dashboardpoc/Graphs/FinancialChart.dart';
// import 'package:dashboardpoc/Graphs/LineChart.dart';
import 'package:dashboardpoc/Graphs/PieChart.dart';
import 'package:dashboardpoc/Graphs/StackedBarChart.dart';
import 'package:dashboardpoc/Graphs/StackedLineChart.dart';
import 'package:dashboardpoc/Graphs/StepArea.dart';
import 'package:flutter/material.dart';

import '../../Utilities/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';

late BuildContext contextLocal;


class WeatherDetails extends StatelessWidget {
   WeatherDetails({
    Key? key,
  }) : super(key: key);


  //final List<Widget> sliderList = [PieChart(),ColumnChart(),BarChart(),FinancialChart(),HistogramChart(),LineChart(),StackedBarChart(),StackedLineChart(),StepAreaChart()];
 // final List<Widget> sliderList = [BarChart(),ColumnChart(),LineChart(),FinancialChart(),HistogramChart(),StackedBarChart(), StackedLineChart(), StepAreaChart(), PieChart()];
  /*
   final List<Widget> sliderList = [BarChart(onTap: () {
   //   Navigator.push(
   //   contextLocal,
   //   MaterialPageRoute(
   //     builder: (context) => GraphView(titleValue: "Bar Chart"),
   //   ),
   // );
     }, isHidden: true,),
     ColumnChart(onTap: () {
   //     Navigator.push(
   //   contextLocal,
   //   MaterialPageRoute(
   //     builder: (context) => GraphView(titleValue: "Column Chart"),
   //   ),
   // );
       }, isHidden: true,),
     // LineChart(onTap: () { Navigator.push(
     //   contextLocal,
     //   MaterialPageRoute(
     //     builder: (context) => GraphView(titleValue: "Line Chart"),
     //   ),
     // ); }, isHidden: true,),
     FinancialChart(onTap: () {
     //   Navigator.push(
     //   contextLocal,
     //   MaterialPageRoute(
     //     builder: (context) => GraphView(titleValue: "Financial Chart"),
     //   ),
     // );
       }, isHidden: true,),
     StackedBarChart(onTap: () {
     //   Navigator.push(
     //   contextLocal,
     //   MaterialPageRoute(
     //     builder: (context) => GraphView(titleValue: "StackedBar Chart"),
     //   ),
     // );
       }, isHidden: true,),
     StackedLineChart(onTap: () {
     //   Navigator.push(
     //   contextLocal,
     //   MaterialPageRoute(
     //     builder: (context) => GraphView(titleValue: "StackedLine Chart"),
     //   ),
     // );
       }, isHidden: true,),
     StepAreaChart(onTap: () {
     //   Navigator.push(
     //   contextLocal,
     //   MaterialPageRoute(
     //     builder: (context) => GraphView(titleValue: "StepArea Chart"),
     //   ),
     // );
       }, isHidden: true,),
     PieChart(onTap: () {
     //   Navigator.push(
     //   contextLocal,
     //   MaterialPageRoute(
     //     builder: (context) => GraphView(titleValue: "Pie Chart"),
     //   ),
     // );
       }, isHidden: true,)
   ];
   */

   final List<Widget> sliderList = [
     BarChart(onTap: () {}, isHidden: true,),
     ColumnChart(onTap: () {}, isHidden: true,),
     FinancialChart(onTap: () {}, isHidden: true,),
     StackedBarChart(onTap: () {}, isHidden: true,),
     StackedLineChart(onTap: () {}, isHidden: true,),
     StepAreaChart(onTap: () {}, isHidden: true,),
     PieChart(onTap: () {}, isHidden: true,)
   ];

   final List<Widget> sliderList1 = [StepAreaChart(onTap: () {}, isHidden: true,)];

   @override
  Widget build(BuildContext context) {
     contextLocal = context;
    final double height = MediaQuery.of(context).size.height;
    return Container(
      height: 450,
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: colorclass.tilesBackGroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          colorclass.shadowView,
        ],
      ),
      child: Container(
        // width: 280,
        padding: EdgeInsets.zero,
        child:CarouselSlider(
          options: CarouselOptions(
            // aspectRatio: 1.5,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            scrollDirection: Axis.horizontal,
            height: height,
            autoPlay: true,
          ),
          items: sliderList,
        ) ,
      )

      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     // Text(
      //     //   "Weather Details",
      //     //   style: TextStyle(
      //     //     fontSize: 18,
      //     //     fontWeight: FontWeight.w500,
      //     //   ),
      //     // ),
      //     SizedBox(height: defaultPadding),
      //     PieChart(),
      //   ],
      // ),
    );
  }
}

