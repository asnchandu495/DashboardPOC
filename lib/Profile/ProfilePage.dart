import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:dashboardpoc/Model/dashboard_model.dart';
import 'package:dashboardpoc/Utilities/constants.dart';
import 'package:flutter/material.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.profile!.viewTitle ?? ""),
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
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 32),
            physics: BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 24),
              CircleAvatar(
                backgroundColor: Colors.greenAccent[70],
                radius: 72,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profile_pics.png'), //NetworkImage
                  radius: 70,
                ), //CircleAvatar
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: model.profile!.firstnameTitle ?? "",
                text: '${model.profile!.firstname ?? ""}',
                onChanged: (name) {},
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: model.profile!.lastnameTitle ?? "",
                text: '${model.profile!.lastname ?? ""}',
                onChanged: (name) {},
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: model.profile!.emailTitle ?? "",
                text: model.profile!.email ?? "",
                onChanged: (email) {},
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: model.profile!.phoneTitle ?? "",
                text: model.profile!.phone ?? "",
                onChanged: (about) {},
              ),
            ],
          ),
      ),

    );
  }

}




class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
    color: Colors.white,
    all: 3,
    child: buildCircle(
      color: color,
      all: 8,
      child: Icon(
        isEdit ? Icons.add_a_photo : Icons.edit,
        color: Colors.white,
        size: 20,
      ),
    ),
  );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}



class TextFieldWidget extends StatefulWidget {
  final int maxLines;
  final String label;
  final String text;
  final ValueChanged<String> onChanged;

  const TextFieldWidget({
    Key? key,
    this.maxLines = 1,
    required this.label,
    required this.text,
    required this.onChanged,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        widget.label,
        style:profileTextStyle,
      ),
      const SizedBox(height: 8),
      TextField (
        enabled: false,
        controller: controller,
        style: gaugeTitleStyle,
        decoration: InputDecoration(
          fillColor: textColor,
          enabledBorder: const OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderSide:  BorderSide(color: textColor, width: 1.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        maxLines: widget.maxLines,
      ),
    ],
  );
}