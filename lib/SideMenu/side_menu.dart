import 'package:dashboardpoc/Dashboard/dashboard_screen.dart';
import 'package:dashboardpoc/Model/dashboard_model.dart';
import 'package:dashboardpoc/Notification/NotificationList.dart';
import 'package:dashboardpoc/Profile/ProfilePage.dart';
import 'package:dashboardpoc/Settings/Settings.dart';
import 'package:dashboardpoc/Tables/TableViews.dart';
import 'package:dashboardpoc/Utilities/constants.dart';
import 'package:flutter/material.dart';

import '../Dashboard/Components/graph_screen.dart';

var localSideContext;
class SideMenu extends StatelessWidget {

   SideMenu({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context)  {
    localSideContext = context;
    return Drawer(
      child: Container(
        decoration:  BoxDecoration(
          gradient:  colorclass.menuBackgroundGradient,
          // LinearGradient(
          //     colors: [
          //       const Color(0xFFFFA69E),
          //       //  const Color(0xFF3366FF),
          //       const Color(0xFF861657),
          //     ],
          //   //   colors:[Colors.blue,  const Color(0xFFFFD600)],
          //     begin: const FractionalOffset(0.0, 0.0),
          //     end: const FractionalOffset(1.0, 0.0),
          //     stops: [0.0, 1.0],
          //     tileMode: TileMode.mirror),
        ),
        child: ListView(
          // padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey, spreadRadius: 1)],
                    ),
                    child: CircleAvatar(
                      maxRadius: 50,
                      backgroundImage: AssetImage('assets/images/profile_pics.png'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DefaultTextStyle(
                    style: const TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'SF',
                        color: Colors.white,
                        fontWeight: FontWeight.w700

                    ),
                    child: Text(
                      style:titleMenuStyle,
                      model.userName ?? "",
                    ),
                    // Center(
                    //   child: AnimatedTextKit(
                    //     repeatForever: false,
                    //     isRepeatingAnimation: false,
                    //     animatedTexts: [
                    //       //  ScaleAnimatedText( drawerMenu.firstName + " " + drawerMenu.lastName,scalingFactor: 0.2),
                    //       //WavyAnimatedText(drawerMenu.firstName + " " + drawerMenu.lastName, speed: Duration(milliseconds: 200)),
                    //     ],
                    //   ),
                    // ),
                  ),
                  /*
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    model.userEmail ?? "",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700, color: Colors.white
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    model.userContact ?? "",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700, color: Colors.white
                    ),
                  ),
                  */
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            Divider(height: 2.0, color: Colors.white70),
            ListView.separated(
                padding: const EdgeInsets.all(0.0),
                separatorBuilder: (context, index) =>Divider(height: 1.0, color: Colors.white70),
                itemCount: (model.menuItems ?? []).length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return  DataPopUp((model.menuItems ?? [])[index],index);
                    // DrawerListTile(title: (model.menuItems ?? [])[index], svgSrc: '', press: () {});
                }),
          ],
        ),
      ),

    );
  }

}

final columns = 4;
final rows = model.weeklyData!.length;

List<List<String>> makeData() {
  final List<List<String>> output = [];
  for (int i = 0; i < columns; i++) {
    final List<String> row = [];
    for (int j = 0; j < rows; j++) {
      // row.add('L$j : T$i');
      switch (i) {
        case 0:
          row.add(model.weeklyData![j].value1 ?? "");
          break;
        case 1:
          row.add(model.weeklyData![j].value2 ?? "");
          break;
        case 2:
          row.add(model.weeklyData![j].value3 ?? "");
          break;
        case 3:
          row.add(model.weeklyData![j].value4 ?? "");
          break;
        default:
          row.add("");
      }
    }
    output.add(row);
  }
  return output;
}

/// Simple generator for column title
List<String> makeTitleColumn() {

  final List<String> output = [];
  // for (int i = 0; i < columns; i++) {
  //   String dateValue = model.weeklyHeaders![i+1];
  //   output.add(dateValue);
  // }
  output.add(model.weeklyData![0].title1 ?? "");
  output.add(model.weeklyData![0].title2 ?? "");
  if ((model.weeklyData![0].title3 ?? "").isNotEmpty){
    output.add(model.weeklyData![0].title3 ?? "");
  }
  if ((model.weeklyData![0].title4 ?? "").isNotEmpty){
    output.add(model.weeklyData![0].title4 ?? "");
  }
  return output;
}

//= model.weeklyHeaders ?? [];

/// Simple generator for row title
List<String> makeTitleRow() {
  final List<String> output = [];
  for (int i = 0; i < rows; i++) {
     String dateValue = model.weeklyData![i].value ?? "";
    output.add(dateValue);
  }
  return output;
}
// => List.generate(rows, (i) => 'Left $i');
/*
class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        if (title.toLowerCase() == "dashboard"){
          Navigator.of(context).pop();

          // Navigator.push(localSideContext,
          //     MaterialPageRoute(builder: (_) => DashboardScreen()));
        }
        if (title.toLowerCase() == "Weather Details".toLowerCase()){
          Navigator.of(context).pop();
          Navigator.push(
            context,
            // MaterialPageRoute(builder: (context) =>  DecoratedTablePage()),
              MaterialPageRoute(builder: (context) =>  DecoratedTablePage(data: makeData(), titleColumn: makeTitleColumn(), titleRow: makeTitleRow())),
          );

        }
      },
      horizontalTitleGap: 0.0,
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),

    );
  }
}
*/

class DataPopUp extends StatefulWidget {

  DataPopUp(this.popup, this.indexVal);
  final MenuItems popup;
  final int indexVal;
  @override
  DataPopUpState createState() => DataPopUpState(popup,indexVal);
}


class DataPopUpState extends State<DataPopUp> {

  DataPopUpState(this.popup, this.indexVal);

  final GlobalKey expansionTileKey = GlobalKey();
  MenuItems popup;
  int indexVal;
  int selected = 0; //attention

  Widget _buildTiles(MenuItems root) {
    if (root.sublist!.isEmpty) {
      return ListTile(
        title:
        Text(
          root.title ?? "",
          style: titleMenuStyle,
        ),
        leading:  ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 30,
            minHeight: 30,
            maxWidth: 30,
            maxHeight: 30,
          ),
          child: Image.asset('assets/images/'+(root.image ?? ""), fit: BoxFit.cover),
        ),
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => HomePage(title: root.title),
          //   ),
          // );

          if ((root.title ?? "").toLowerCase() == "dashboard"){
            Navigator.of(context).pop();

            // Navigator.push(localSideContext,
            //     MaterialPageRoute(builder: (_) => DashboardScreen()));
          }
          // if ((root.title ?? "").toLowerCase() == "Weather Details".toLowerCase()){
          //   Navigator.of(context).pop();
          //   Navigator.push(
          //     context,
          //     // MaterialPageRoute(builder: (context) =>  DecoratedTablePage()),
          //     MaterialPageRoute(builder: (context) =>  DecoratedTablePage(data: makeData(), titleColumn: makeTitleColumn(), titleRow: makeTitleRow())),
          //   );
          // }
          if (indexVal == 2){

            Navigator.of(context).pop();
            Navigator.push(
              context,
              // MaterialPageRoute(builder: (context) =>  DecoratedTablePage()),
              MaterialPageRoute(builder: (context) =>  DecoratedTablePage(data: makeData(), titleColumn: makeTitleColumn(), titleRow: makeTitleRow())),
            );

          }
          if ((root.title ?? "").toLowerCase() == "Notifications".toLowerCase()){
            Navigator.of(context).pop();
            Navigator.push(
              context,
              // MaterialPageRoute(builder: (context) =>  DecoratedTablePage()), NotificationViewScreen
              MaterialPageRoute(builder: (context) =>  NotificationViewScreen()),
            );

          }
          if ((root.title ?? "").toLowerCase() == "profile".toLowerCase()){
            Navigator.of(context).pop();
            Navigator.push(
              context,
              // MaterialPageRoute(builder: (context) =>  DecoratedTablePage()), NotificationViewScreen
              MaterialPageRoute(builder: (context) =>  ProfilePage()),
            );

          }
          if ((root.title ?? "").toLowerCase() == "Settings".toLowerCase()){
            Navigator.of(context).pop();
            Navigator.push(
              context,
              // MaterialPageRoute(builder: (context) =>  DecoratedTablePage()), NotificationViewScreen
              MaterialPageRoute(builder: (context) =>  SettingScreen()),
            );

          }

        },
      );
    }
    return ExpansionTile(
      //key: expansionTileKey,
        initiallyExpanded : indexVal==selected, //attention
        key: Key(indexVal.toString()), //attention
        title:
        Text(
          root.title ?? "",
          style: titleMenuStyle,
        ),
        leading:  ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 30,
            minHeight: 30,
            maxWidth: 30,
            maxHeight: 30,
          ),
          child: Image.asset('assets/images/'+(root.image ?? ""), fit: BoxFit.cover),
        ),
        // leading: Icon(IconData(int.parse(root.image),fontFamily: "'MaterialIcons'"), color: Colors.black54),
        children: (root.sublist ?? []).map<Widget>((player) => showPlayers(player)).toList(),
        onExpansionChanged: ((newState){
          if(newState)
            setState(() {
              Duration(seconds:  20000);
              selected = indexVal;
            });
          else setState(() {
            selected = -1;
          });

        })
    );
  }


  @override
  Widget build(BuildContext context) {
    return _buildTiles(popup);
  }

  // @override
  // State<StatefulWidget> createState() {
  //   // TODO: implement createState
  //    _buildTiles(popup);
  // }

  showPlayers(Sublist player) {
    return  ListTile(
      title:  Text(
        '           '+(player.title ?? ""),
        style: new TextStyle(fontSize: 18, color: Colors.white),
      ),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GraphView(titleValue: player.title ?? ""),
          ),
        );
      },
    );
  }
}
