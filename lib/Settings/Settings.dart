import 'package:dashboardpoc/Utilities/constants.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:dashboardpoc/Model/dashboard_model.dart';
import 'package:flutter/material.dart';



class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  bool status = model.setting!.notificationValue ?? false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.setting!.title ?? ""),
        flexibleSpace: Container(
            decoration:BoxDecoration(
              gradient:colorclass.gradientValue,
            )
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
          decoration:BoxDecoration(
              gradient:colorclass.menuBarGradient,
              boxShadow: [
                colorclass.shadowView,
              ]
          ),
        child: ListView(
          children: <Widget>[
            ListTile(
              title:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // mainAxisAlignment: MainAxisAlignment.t,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child:Text(
                      model.setting!.notificationTitle ?? "",
                      style: notifiTitleStyle,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child:FlutterSwitch(
                      activeColor: switchActivateColor,
                      inactiveColor: switchInactivateColor,
                      width: 55.0,
                      height: 25.0,
                      valueFontSize: 12.0,
                      toggleSize: 18.0,
                      value: status,// model.setting!.notificationValue ?? false,
                      onToggle: (val) {
                        setState(() {
                          status = val;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}