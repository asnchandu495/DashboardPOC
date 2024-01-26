import 'package:dashboardpoc/Model/dashboard_model.dart';
import 'package:dashboardpoc/Utilities/constants.dart';
import 'package:flutter/material.dart';

class NotificationViewScreen extends StatefulWidget {
  @override
  _NotificationViewScreenState createState() => _NotificationViewScreenState();
}

class _NotificationViewScreenState extends State<NotificationViewScreen> {

  // List listValues = [];

  List<NotificationList>? listValues = model.notification!.notificationList!;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // listValues = listValues?.sort((a,b) => (a.date ?? "").compareTo(b.date ?? ""));
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(model.notification!.title ?? ""),
        flexibleSpace: Container(
            decoration:BoxDecoration(
              gradient:colorclass.gradientValue,
            )
        ),
      ),
      body: Container(
          padding: const EdgeInsets.all(10.0),
          decoration:BoxDecoration(
              gradient:colorclass.menuBarGradient,
              boxShadow: [
                colorclass.shadowView,
              ]
          ),
          child: ListView.builder(
            itemCount: model.notification!.notificationList!.length,
            itemBuilder: (context, index) {
              // return _listItem(index);
              return Column(
                children: <Widget>[
                  _listItem(index),
                  Divider(
                    color: textColor,
                  ), //                           <-- Divider
                ],
              );
            },
          ),
      ),

    );
  }
}


Widget _listItem(index) {
  var notificationItem = model.notification!.notificationList![index];
  return Container(
    child: ListTile(
      title: Padding(
      padding: const EdgeInsets.only(top: 5),
        child: Text(notificationItem.title ?? "",
          style: subTitleStyle,
        ),
      ),

      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 5,bottom: 5),
            child: Text(
              notificationItem.subTitle ?? "",
              textAlign: TextAlign.left,
              style: titleStyle,
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
             daysBetween(notificationItem.date ?? ""),
            textAlign: TextAlign.right,
            style: notifDateStyle,// has impact
            ),
          )
        ],
      ),
    ),
  );

}

String daysBetween(String fromValue) {
  DateTime from = DateTime.parse(fromValue);
  DateTime to = DateTime.now();

  String returnValue = '';

  // int seconds = to.difference(from).inSeconds;
  // if (seconds < 60)
  //   return '$seconds seconds ago';
  // else if (seconds >= 60 && seconds < 3600)
  //   return '${to.difference(from).abs()} minutes ago';
  // else if (seconds >= 3600 && seconds < 86400)
  //   return '${to.difference(from).inHours} hours ago';
  // else
  //   return '${to.difference(from).inDays} days ago';

  int differenceDaysValue  = (to.difference(from).inDays).round();
  if (differenceDaysValue < 1) {
    int differenceHoursValue  = (to.difference(from).inHours).round();
    if (differenceHoursValue < 1) {
      int differenceMinValue  = (to.difference(from).inMinutes).round();
      returnValue = "${differenceMinValue} minutes ago";
    } else {
      returnValue = "${differenceHoursValue} hours ago";
    }
  } else {
    returnValue = "${differenceDaysValue} days ago";
  }

  return returnValue;
}

String calculateTimeDifferenceBetween(
{required DateTime startDate, required DateTime endDate}) {
int seconds = endDate.difference(startDate).inSeconds;
if (seconds < 60)
return '$seconds second';
else if (seconds >= 60 && seconds < 3600)
return '${startDate.difference(endDate).inMinutes.abs()} minute';
else if (seconds >= 3600 && seconds < 86400)
return '${startDate.difference(endDate).inHours} hour';
else
return '${startDate.difference(endDate).inDays} day';
}