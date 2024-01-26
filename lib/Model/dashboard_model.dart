class dashboard_model {
  String? companyname;
  String? userName;
  String? userContact;
  String? userEmail;
  List<MenuItems>? menuItems;
  List<DashboardData>? dashboardData;
  List<String>? weeklyHeaders;
  Units? units;
  List<WeeklyData>? weeklyData;
  Notification? notification;
  Profile? profile;
  Setting? setting;

  dashboard_model(
      {this.companyname,
        this.userName,
        this.userContact,
        this.userEmail,
        this.menuItems,
        this.dashboardData,
        this.weeklyHeaders,
        this.units,
        this.weeklyData,
        this.notification,
        this.setting,
        this.profile});

  dashboard_model.fromJson(Map<String, dynamic> json) {
    companyname = json['companyname'];
    userName = json['user_name'];
    userContact = json['user_contact'];
    userEmail = json['user_email'];
    if (json['menu_items'] != null) {
      menuItems = <MenuItems>[];
      json['menu_items'].forEach((v) {
        menuItems!.add(new MenuItems.fromJson(v));
      });
    }
    if (json['dashboard_data'] != null) {
      dashboardData = <DashboardData>[];
      json['dashboard_data'].forEach((v) {
        dashboardData!.add(new DashboardData.fromJson(v));
      });
    }
    weeklyHeaders = json['weekly_headers'].cast<String>();
    units = json['units'] != null ? new Units.fromJson(json['units']) : null;
    if (json['weekly_data'] != null) {
      weeklyData = <WeeklyData>[];
      json['weekly_data'].forEach((v) {
        weeklyData!.add(new WeeklyData.fromJson(v));
      });
    }
    notification = json['notification'] != null
        ? new Notification.fromJson(json['notification'])
        : null;
    profile = json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    setting =
    json['setting'] != null ? new Setting.fromJson(json['setting']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyname'] = this.companyname;
    data['user_name'] = this.userName;
    data['user_contact'] = this.userContact;
    data['user_email'] = this.userEmail;
    if (this.menuItems != null) {
      data['menu_items'] = this.menuItems!.map((v) => v.toJson()).toList();
    }
    if (this.dashboardData != null) {
      data['dashboard_data'] =
          this.dashboardData!.map((v) => v.toJson()).toList();
    }
    data['weekly_headers'] = this.weeklyHeaders;
    if (this.units != null) {
      data['units'] = this.units!.toJson();
    }
    if (this.weeklyData != null) {
      data['weekly_data'] = this.weeklyData!.map((v) => v.toJson()).toList();
    }
    if (this.notification != null) {
      data['notification'] = this.notification!.toJson();
    }
    if (this.setting != null) {
      data['setting'] = this.setting!.toJson();
    }
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    return data;
  }
}

class MenuItems {
  String? title;
  String? image;
  List<Sublist>? sublist;
  bool? isExpanded;

  MenuItems({this.title, this.image, this.sublist, this.isExpanded = false});

  MenuItems.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    isExpanded = false;
    if (json['sublist'] != null) {
      sublist = <Sublist>[];
      json['sublist'].forEach((v) {
        sublist!.add(new Sublist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['image'] = this.image;
    data['isExpanded'] = this.isExpanded;
    if (this.sublist != null) {
      data['sublist'] = this.sublist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sublist {
  String? title;
  String? image;

  Sublist({this.title, this.image});

  Sublist.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['image'] = this.image;
    return data;
  }
}

class DashboardData {
  String? title;
  String? value;
  String? image;

  DashboardData({this.title, this.value, this.image});

  DashboardData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    value = json['value'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['value'] = this.value;
    data['image'] = this.image;
    return data;
  }
}

class Units {
  String? temperature;
  String? humidity;
  String? precipitation;
  String? wind;

  Units({this.temperature, this.humidity, this.precipitation, this.wind});

  Units.fromJson(Map<String, dynamic> json) {
    temperature = json['temperature'];
    humidity = json['humidity'];
    precipitation = json['precipitation'];
    wind = json['wind'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temperature'] = this.temperature;
    data['humidity'] = this.humidity;
    data['precipitation'] = this.precipitation;
    data['wind'] = this.wind;
    return data;
  }
}

class Notification {
  String? title;
  List<NotificationList>? notificationList;

  Notification({this.title, this.notificationList});

  Notification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['notification_list'] != null) {
      notificationList = <NotificationList>[];
      json['notification_list'].forEach((v) {
        notificationList!.add(new NotificationList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.notificationList != null) {
      data['notification_list'] =
          this.notificationList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationList {
  String? title;
  String? subTitle;
  String? date;

  NotificationList({this.title, this.subTitle, this.date});

  NotificationList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subTitle = json['sub_title'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['sub_title'] = this.subTitle;
    data['date'] = this.date;
    return data;
  }
}

class Profile {
  String? viewTitle;
  String? firstnameTitle;
  String? firstname;
  String? lastnameTitle;
  String? lastname;
  String? phoneTitle;
  String? phone;
  String? emailTitle;
  String? email;
  String? nameTitle;

  Profile(
      {this.viewTitle,
        this.firstnameTitle,
        this.firstname,
        this.lastnameTitle,
        this.lastname,
        this.phoneTitle,
        this.phone,
        this.emailTitle,
        this.email,
        this.nameTitle
      });

  Profile.fromJson(Map<String, dynamic> json) {
    viewTitle = json['view_title'];
    firstnameTitle = json['firstname_title'];
    firstname = json['firstname'];
    lastnameTitle = json['lastname_title'];
    lastname = json['lastname'];
    phoneTitle = json['phone_title'];
    phone = json['phone'];
    emailTitle = json['email_title'];
    email = json['email'];
    nameTitle = json['name_title'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['view_title'] = this.viewTitle;
    data['firstname_title'] = this.firstnameTitle;
    data['firstname'] = this.firstname;
    data['lastname_title'] = this.lastnameTitle;
    data['lastname'] = this.lastname;
    data['phone_title'] = this.phoneTitle;
    data['phone'] = this.phone;
    data['email_title'] = this.emailTitle;
    data['email'] = this.email;
    data['name_title'] =  this.nameTitle;
    return data;
  }
}
class Setting {
  String? title;
  String? notificationTitle;
  bool? notificationValue;

  Setting({this.title, this.notificationTitle, this.notificationValue});

  Setting.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    notificationTitle = json['notification_title'];
    notificationValue = json['notification_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['notification_title'] = this.notificationTitle;
    data['notification_value'] = this.notificationValue;
    return data;
  }
}
class WeeklyData {
  String? title;
  String? value;
  String? title1;
  String? value1;
  String? title2;
  String? value2;
  String? title3;
  String? value3;
  String? title4;
  String? value4;
  String? title5;
  String? value5;
  String? title6;
  String? value6;
  String? title1Unit;
  String? title2Unit;
  String? title3Unit;
  String? title4Unit;

  WeeklyData(
      {this.title,
        this.value,
        this.title1,
        this.value1,
        this.title2,
        this.value2,
        this.title3,
        this.value3,
        this.title4,
        this.value4,
        this.title5,
        this.value5,
        this.title6,
        this.value6,
        this.title1Unit,
        this.title2Unit,
        this.title3Unit,
        this.title4Unit});

  WeeklyData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    value = json['value'];
    title1 = json['title1'];
    value1 = json['value1'];
    title2 = json['title2'];
    value2 = json['value2'];
    title3 = json['title3'];
    value3 = json['value3'];
    title4 = json['title4'];
    value4 = json['value4'];
    title5 = json['title5'];
    value5 = json['value5'];
    title6 = json['title6'];
    value6 = json['value6'];
    title1Unit = json['title1_unit'];
    title2Unit = json['title2_unit'];
    title3Unit = json['title3_unit'];
    title4Unit = json['title4_unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['value'] = this.value;
    data['title1'] = this.title1;
    data['value1'] = this.value1;
    data['title2'] = this.title2;
    data['value2'] = this.value2;
    data['title3'] = this.title3;
    data['value3'] = this.value3;
    data['title4'] = this.title4;
    data['value4'] = this.value4;
    data['title5'] = this.title5;
    data['value5'] = this.value5;
    data['title6'] = this.title6;
    data['value6'] = this.value6;
    data['title1_unit'] = this.title1Unit;
    data['title2_unit'] = this.title2Unit;
    data['title3_unit'] = this.title3Unit;
    data['title4_unit'] = this.title4Unit;
    return data;
  }
}

dashboard_model model = dashboard_model();