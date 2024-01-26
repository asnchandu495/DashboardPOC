import 'package:dashboardpoc/Utilities/weather.dart';
import 'package:flutter/material.dart';




String dataPath = "assets/dashboard.json";

// String dataPath = "assets/FinancialReport.json";

String title = "title";
String value = "value";

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);

const defaultPadding = 15.0;
const textColor = Colors.black;

const headerTextColor = Colors.white;

const switchActivateColor = Colors.green;
const switchInactivateColor = Colors.redAccent;

List weatherBackgroundList = ["01d","02d","01n","10n"];  //["01d","02d","01n","10n","13n"];

class colorclass {

   static Color tilesBackGroundColor = Colors.white.withOpacity(0.9);

   static Color tilesShadowColor = Colors.grey.withOpacity(0.3);

   static Color textColor = Colors.black;

   static BoxShadow shadowView =  BoxShadow(
   color: colorclass.tilesShadowColor,
   // spreadRadius: 2,
   // blurRadius: 7,
   offset: Offset(2,2),
   spreadRadius: 2.0,
   blurRadius: 7.0,// changes position of shadow
   );

  //main screen background
   static LinearGradient gradientValue = WeatherModel().getBackgroundColorWeather("04d"); //("10d");

   static LinearGradient menuBarGradient = WeatherModel().getBackgroundColorWeather("01d");

   static LinearGradient menuBackgroundGradient = WeatherModel().getBackgroundColorWeather("13d");

   //E9004C

   static LinearGradient navigationBarColor = WeatherModel().getBackgroundColorWeather("04d");

   static LinearGradient graphviewValue = WeatherModel().getBackgroundColorWeather("02n");

}


const titleStyle = TextStyle (
    fontSize: 18,
    color: textColor
);
const titleTileStyle = TextStyle (
    fontSize: 16,
    color: textColor,
    fontWeight: FontWeight.bold
);

const titleMenuStyle = TextStyle (
    fontSize: 18,
    color: Colors.white
);

const gaugeTitleStyle = TextStyle (
    fontSize: 16,
    color: textColor
);

const subTitleStyle = TextStyle (
    fontSize: 14,
    color: textColor
);
const subTitleTilesStyle = TextStyle (
    fontSize: 13,
    color: textColor,
    fontWeight: FontWeight.bold
);

const pieTitleStyle = TextStyle (
    fontSize: 12,
    color: textColor
);

const titleBoldStyle =  TextStyle(
    fontSize: 14,
    color: textColor,
    fontWeight: FontWeight.bold
);
const notifiTitleStyle = TextStyle (
    fontSize: 20,
    color: textColor,
    fontWeight: FontWeight.bold
);
const gaugeTempBoldStyle =  TextStyle(
    fontSize: 18,
    color: textColor,
    fontWeight: FontWeight.bold
);

const notifDateStyle = TextStyle(
    fontWeight: FontWeight.w700,
    color: textColor
);

const profileTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 16,  color: textColor);


class StrIntCurrency {
   // Indonesian Currency
   String intToStringID(int value, {bool symbol = true}){
      final String str = value.toString();
      String result = "";
      if(symbol == true){
         result += "";
      }
      for(var i = 0; i < str.length; i++) {
         if(str.length%3 == 1){
            if(i%3 == 0 && i+1 != str.length){
               result = result + str[i] + ",";
            }else{
               result = result + str[i] ;
            }

         }else if(str.length%3 == 2){
            if(i%3 == 1 && i+1 != str.length){
               result = result + str[i] + ",";
            }else{
               result = result + str[i] ;
            }
         }else{
            result = result + str[i];
         }

      }
      return result;
   }
   int stringToIntID(String value){
      String str = "";
      if(value[0] == "R"){
         str += value.substring(3, value.length-3);
      }else{
         str += value.substring(0, value.length-3);
      }

      return int.parse(str.replaceAll(",",""));
   }
}

const durationAnimation = 100;

