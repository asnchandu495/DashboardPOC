
import 'package:dashboardpoc/Gauges/LinearGauge.dart';
import 'package:dashboardpoc/Graphs/BarChart.dart';
import 'package:dashboardpoc/Graphs/ColumnChart.dart';
import 'package:dashboardpoc/Graphs/FinancialChart.dart';
import 'package:dashboardpoc/Graphs/LineChart.dart';
import 'package:dashboardpoc/Graphs/PieChart.dart';
import 'package:dashboardpoc/Graphs/StackedBarChart.dart';
import 'package:dashboardpoc/Graphs/StackedLineChart.dart';
import 'package:dashboardpoc/Graphs/StepArea.dart';
import 'package:dashboardpoc/GridView/GridView.dart';
import 'package:dashboardpoc/Tables/TableViews.dart';
import 'package:flutter/material.dart';
import 'dart:math';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Generate dummy data to feed the list view
  final List _peopleData = List.generate(1000, (index) {
    return {"name": "Person \#$index", "age": Random().nextInt(90) + 10};
  });

  final columns = 10;
  final rows = 20;

  List<List<String>> makeData() {
    final List<List<String>> output = [];
    for (int i = 0; i < columns; i++) {
      final List<String> row = [];
      for (int j = 0; j < rows; j++) {
        row.add('L$j : T$i');
      }
      output.add(row);
    }
    return output;
  }

  /// Simple generator for column title
  List<String> makeTitleColumn() => List.generate(columns, (i) => 'Top $i');

  /// Simple generator for row title
  List<String> makeTitleRow() => List.generate(rows, (i) => 'Left $i');


  final List listOfStyles = ["LineChart", "BarChart","PieChart","ColumnChart","StackedLineChart","StackedBarChart","StepArea","Financial Chart","Stricky Headers Table","Grid View","Radial Gauge"];
  // Item of the ListView
  Widget _listItem(index) {
    int indexVal = index+1;
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListTile(
        leading: Text(indexVal.toString(), style: const TextStyle(fontSize: 18)),
        title: Text(
          // _peopleData[index]['name'].toString(),
          listOfStyles[index],
          style: const TextStyle(fontSize: 18),
        ),
        onTap: (){
          if(indexVal == 1){
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LineChart()));
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const LineChart()),
            // );
          }
          if(indexVal == 2){
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const BarChart()),
            // );
          }
          if(indexVal == 3){
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const PieChart()),
            // );
          }
          if(indexVal == 4){
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const ColumnChart()),
            // );
          }
          if(indexVal == 5){
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const StackedLineChart()),
            // );
          }
          if(indexVal == 6){
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const StackedBarChart()),
            // );
          }
          if(indexVal == 7){
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const StepAreaChart()),
            // );
          }
          if(indexVal == 8){
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const FinancialChart()),
            // );
          }
          //DecoratedTablePage
          if(indexVal == 9){
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) =>  DecoratedTablePage(data: makeData(), titleColumn: makeTitleColumn(), titleRow: makeTitleRow())),
            // );
          }
          if(indexVal == 10){
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => GridDashboard() ),
            // );
          }
          if(indexVal == 11){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LinearGauge() ),
            );
          }
        },
        // trailing: Text(_peopleData[index]['age'].toString(),
        //     style: const TextStyle(fontSize: 18, color: Colors.purple)),
      ),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black26))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('DashBoard'),
        ),
        body: Column(
          children: [
            // Container(
            //   padding: const EdgeInsets.all(10),
            //   color: Colors.amber,
            //   child: const ListTile(
            //     leading: Text('ID'),
            //     title: Text('Name'),
            //     trailing: Text('Age'),
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
                  itemCount: listOfStyles.length,
                  itemBuilder: (_, index) {
                    return _listItem(index);
                    // return ListTile(
                    //   title: Text(listOfStyles[index]),
                    // );
                  }),
            ),
          ],
        ));
  }
}