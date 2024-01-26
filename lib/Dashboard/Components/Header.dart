import 'package:dashboardpoc/Model/dashboard_model.dart';
import 'package:dashboardpoc/SideMenu/MenuController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Utilities/responsive.dart';

import '../../Utilities/constants.dart';

class Header extends StatelessWidget {
   Header({
    Key? key,
  }) : super(key: key);

  String viewTitle = (model.menuItems ?? []).isNotEmpty ? ((model.menuItems ?? [])[0].title ?? ""):"";

  @override
  Widget build(BuildContext context) {
    return Container( //ColoredBox
        // color: const Color(0xFF861123),
      decoration: BoxDecoration(
        gradient: colorclass.gradientValue,
      ),
      child:Row(
        children: [
          if (!Responsive.isDesktop(context))
            IconButton(
              icon:  Icon(Icons.menu,
                color: Colors.white,
              ),
              onPressed: context.read<MenuController>().controlMenu,
            ),
          // if (!Responsive.isDesktop(context))
          //   Text(
          //     "Dashboard",
          //     style: Theme.of(context).textTheme.headline6,
          //   ),
          if (!Responsive.isMobile(context))
            Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
            Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
          Align(
            alignment: Alignment.center,
            child:
            // Expanded(
            Container(
              padding: EdgeInsets.all(defaultPadding),
              margin: EdgeInsets.symmetric(horizontal: defaultPadding),
                child:
                Text(viewTitle,
                 // style: Theme.of(context).textTheme.headline6,
                  style: gaugeTempBoldStyle,
                ),
            ),
            // ),
          ),

          if (!Responsive.isMobile(context))
            Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
           Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
           // ProfileCard()
        ],
      ) ,
    );

  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.blueGrey),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/profile_pic.png",
            height: 38,
          ),
          if (!Responsive.isMobile(context))
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text("Angelina Jolie"),
            ),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}