import 'package:dashboardpoc/Model/sample_view.dart';
import 'package:flutter/material.dart';

/// Renders the gauge pointer bounce out animation sample
class GridDashboard extends SampleView {
  /// Creates the gauge pointer bounce out animation sample
  const GridDashboard(Key key) : super(key: key);

  @override
  _RadialBounceOutExampleState createState() => _RadialBounceOutExampleState();
}

class _RadialBounceOutExampleState extends SampleViewState {
  _RadialBounceOutExampleState();

  @override
  Widget build(BuildContext context) {

    var color = 0xff453658;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Grid View',
          maxLines: 2,
        ),
        // backgroundColor: Colors.amber,
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child:GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return Container(
              decoration: BoxDecoration(
                color: Color(color),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(data.img, width: 42),
                  SizedBox(height: 14),
                  // Text(
                  //   data.title,
                  //   style: const TextStyle(fontSize: 20),
                  // ),
                  Text(
                    data.title,
                    style: const TextStyle(fontSize: 18,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    data.subtitle,
                    style: const TextStyle(
                        fontSize: 14,
                      color: Colors.white
                    ),
                  ),
                  SizedBox(height: 14),
                  Text(
                    data.event,
                    style: const TextStyle(fontSize: 18,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      )
    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Items({required this.title, required this.subtitle, required this.event, required this.img});
}

Items item1 = new Items(
    title: "Calendar",
    subtitle: "March, Wednesday",
    event: "3 Events",
    img: "assets/images/calendar.png");

Items item2 = new Items(
  title: "Groceries",
  subtitle: "Bocali, Apple",
  event: "4 Items",
  img: "assets/images/food.png",
);
Items item3 = new Items(
  title: "Locations",
  subtitle: "Lucy Mao",
  event: "",
  img: "assets/images/map.png",
);
Items item4 = new Items(
  title: "Activity",
  subtitle: "Rose favirited your Post",
  event: "",
  img: "assets/images/festival.png",
);
Items item5 = new Items(
  title: "To do",
  subtitle: "Homework, Design",
  event: "4 Items",
  img: "assets/images/todo.png",
);
Items item6 = new Items(
  title: "Settings",
  subtitle: "",
  event: "2 Items",
  img: "assets/images/setting.png",
);

List<Items> myList = [item1, item2, item3, item4];