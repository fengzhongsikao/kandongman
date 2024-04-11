import 'package:flutter/material.dart';

myCustomButton({
  required VoidCallback onTap,
  double width = 140,
  double height = 44,
  Color gbColor = Colors.white,
  String title = "button",
  Color fontColor = Colors.red,
  Color borderColor = Colors.red,
  double fontSize = 16,
  double borderRadius = 4.0,
  double right = 0.0,
  double borderWidth = 1,
  String fontName = "Montserrat",
  FontWeight fontWeight = FontWeight.w400,
}) {
  return Container(
    margin: EdgeInsets.only(right: right),
    child: SizedBox(
      width: width,
      height: height,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              side: BorderSide(color: borderColor, width: borderWidth),
            ),
            color: gbColor,
          ),
          child: Center(
              child: Text(
            title,
            style: TextStyle(color: fontColor, fontSize: fontSize),
          )),
        ),
      ),
    ),
  );
}
