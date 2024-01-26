
import 'package:dashboardpoc/Model/dashboard_model.dart';
import 'package:flutter/material.dart';

import '../../Utilities/constants.dart';
import 'package:data_table_2/data_table_2.dart';


class RecentFiles extends StatelessWidget {
  const RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       padding: EdgeInsets.all(defaultPadding-10),
      decoration: BoxDecoration(
        color: colorclass.tilesBackGroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          colorclass.shadowView,
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   "Recent Data",
          //   style: Theme.of(context).textTheme.subtitle1,
          // ),
          SizedBox(
            width: double.infinity,
            height: 270,
            child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 400,
              columns: [
                DataColumn(
                  label: Text((model.weeklyData ?? []).isNotEmpty ? (model.weeklyData ?? [])[0].title ?? "" : "",
                    style: titleBoldStyle,
                  ),
                ),
                DataColumn(
                  label: Text((model.weeklyData ?? []).isNotEmpty ? (model.weeklyData ?? [])[0].title1 ?? "" : "",
                    style: titleBoldStyle,
                  ),
                ),
                DataColumn(
                  label: Text((model.weeklyData ?? []).isNotEmpty ? (model.weeklyData ?? [])[0].title2 ?? "" : "",
                    style: titleBoldStyle,
                  ),
                ),
              ],
              rows: List.generate(
                (model.weeklyData ?? []).length,
                    (index) => recentFileDataRow((model.weeklyData ?? [])[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(WeeklyData fileInfo) {
  return
    DataRow(
    cells: [
      DataCell(
          Text(fileInfo.value ?? "",
            style: subTitleStyle,
          )
      ),
      DataCell(
          Text('${fileInfo.value1 ?? ""}${fileInfo.title1Unit ?? ""} ',
            style: subTitleStyle,
          )
      ),
      DataCell(
          Text('${fileInfo.value2 ?? ""} ${fileInfo.title2Unit ?? ""}',
            style: subTitleStyle,
          )
      ),
    ],
  );
}


class RecentFile {
  final String? icon, title, date, size;

  RecentFile({this.icon, this.title, this.date, this.size});
}

List demoRecentFiles = [
  RecentFile(
    icon: "assets/icons/xd_file.svg",
    title: "XD File",
    date: "01-03-2021",
    size: "3.5mb",
  ),
  RecentFile(
    icon: "assets/icons/Figma_file.svg",
    title: "Figma File",
    date: "27-02-2021",
    size: "19.0mb",
  ),
  RecentFile(
    icon: "assets/icons/doc_file.svg",
    title: "Document",
    date: "23-02-2021",
    size: "32.5mb",
  ),
  RecentFile(
    icon: "assets/icons/sound_file.svg",
    title: "Sound File",
    date: "21-02-2021",
    size: "3.5mb",
  ),
  RecentFile(
    icon: "assets/icons/media_file.svg",
    title: "Media File",
    date: "23-02-2021",
    size: "2.5gb",
  ),
  RecentFile(
    icon: "assets/icons/pdf_file.svg",
    title: "Sales PDF",
    date: "25-02-2021",
    size: "3.5mb",
  ),
  RecentFile(
    icon: "assets/icons/excle_file.svg",
    title: "Excel File",
    date: "25-02-2021",
    size: "34.5mb",
  ),
];