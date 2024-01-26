import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import '../../Model/dashboard_model.dart';
import 'MyFiles.dart';
import '../../Utilities/constants.dart';


 List<Color> colorsList = [Colors.red, Colors.blue, Colors.amberAccent, Colors.deepPurple];

class FileInfoCard extends StatelessWidget {
  const FileInfoCard({
    Key? key,
    required this.info,
    required this.indexVal,
  }) : super(key: key);

  final DashboardData info;
  final int indexVal;

  double returnProgressValue() {

    int intValue = int.parse((info.value ?? "").replaceAll(RegExp('[^0-9]'), ''));

    return intValue.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: colorclass.tilesBackGroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          colorclass.shadowView,
        ],
      ),
      child:
      Stack(
        alignment: Alignment.topCenter,
        children: [
          // Image.asset(
          //   // you can replace this with Image.asset
          //   'assets/images/${info.image ?? ""}',
          //   fit: BoxFit.cover,
          //   height: 30,
          //   width: 30,
          // ),
          // you can replace

          Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Image.asset('assets/images/${info.image ?? ""}', width: 30),
              ),
              const SizedBox(
                height: 3,
              ),
              Center(
                child: Text(
                  info.value ?? "",
                  style: subTitleTilesStyle,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  info.title ?? "",
                  style: titleTileStyle,
                ),
              ),
            ],
          ),
          SimpleCircularProgressBar(
            valueNotifier:  ValueNotifier(returnProgressValue()),
            size: 74,
            progressStrokeWidth: 5,
            backStrokeWidth: 5,
            progressColors: [colorsList[indexVal]],
            backColor: Colors.black12,
          ),
          // Text(
          //   info.title ?? "",
          //   style: titleStyle,
          // ),
        ],
      ),
      /*
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Image.asset('assets/images/${info.image ?? ""}', width: 42),
          ),
          Center(
            child: Text(
              info.title ?? "",
              style: titleStyle,
            ),
          ),
          // SizedBox(height: 8),
          Center(
            child: Text(
              info.value ?? "",
              style: subTitleStyle,
            ),
          ),
        ],
      ),*/
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = primaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color? color;
  final int? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
