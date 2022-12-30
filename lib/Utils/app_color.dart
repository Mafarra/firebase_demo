import 'package:flutter/material.dart';

class AppColor {
  static Color primary = _getPrimaryColor();// HexColor.fromHex("#0F3057"):; //dark
  static Color userPrimary = _getPrimaryColor();//HexColor.fromHex("#0F3057"); //for JobME APP
  static Color userSecondry = _getSecondaryColor();//HexColor.fromHex("#F28121"); //for JobME APP //secondary
  static Color primaryColorAccent = HexColor.fromHex("#0F3057"); //orange
  static Color darkGrey = HexColor.fromHex("#525252");
  static Color grey = HexColor.fromHex("#737477");
  // static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color primaryOpacity70 = _getOpacityPrimaryColor();// HexColor.fromHex("#B326C3AE");
  static Color darkYellow = HexColor.fromHex("#CDAD0A");
  static Color lightBlue = HexColor.fromHex("#E9F0F1");

  // new colors

  static Color lightGrey = Colors.grey[100]!;
  static Color lightGreyHeader = Colors.grey[400]!;
  static Color darkPrimary =_getDarkPrimary(); //HexColor.fromHex("#0F3057");
  static Color grey1 = HexColor.fromHex("#707070");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color error = HexColor.fromHex("#e61f34"); // red color
  static Color transparent = Colors.transparent;
  static Color black = HexColor.fromHex("#000000");
  static Color scaffold = HexColor.fromHex("#F5F5F7");

  static Color colorApproved = HexColor.fromHex("#CCEDDC");
  static Color colorInProcessing = HexColor.fromHex("#FFB300");//colorInProcessing
  static Color colorNew = HexColor.fromHex("#E0DFE2");
  static Color colorRejected = HexColor.fromHex("#e61f34");

  static Color primaryCompany = HexColor.fromHex("#07917F");// HexColor.fromHex("#0F3057"):; //dark
  static Color userPrimaryCompany = HexColor.fromHex("#07917F");//HexColor.fromHex("#0F3057"); //for JobME APP
  static Color userSecondryCompany = _getSecondaryColor();//HexColor.fromHex("#F28121"); //for JobME APP //secondary
  static Color primaryOpacity70Company= const Color.fromARGB(172, 95, 57, 67);// HexColor.fromHex("#B326C3AE");
  static Color darkPrimaryCompany =HexColor.fromHex("#07917F"); //HexColor.fromHex("#0F3057");

  //this for checkBox style
  static Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return AppColor.userPrimary;
    }
    return AppColor.userPrimary ;
  }

  // static bool _isUser(){
  //   return SharedPref.instance.getIsUserKey();
  // }

  static Color _getPrimaryColor() {
    return  /*_isUser() ?*/HexColor.fromHex("#0F3057") /*:HexColor.fromHex("#07917F")*/;
  }

  static Color _getSecondaryColor() {
    return HexColor.fromHex("#F28121");
  }

  static Color _getOpacityPrimaryColor() {
    return /* _isUser() ?*/const Color.fromARGB(213, 83, 34, 77)/*:const Color.fromARGB(172, 95, 57, 67)*/;//HexColor.fromHex("#07917F");
  }

  static Color _getDarkPrimary() {
    return /*_isUser() ?*/HexColor.fromHex("#0F3057") /*:HexColor.fromHex("#07917F")*/;
  }
}

extension HexColor on Color {
  static fromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
