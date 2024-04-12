import 'package:flutter/material.dart';

/// @Description :
/// @Author : fong
/// @Date:  2024/4/12  12:25


searchBoxLess({required Function onTap,Color? iconColor}){
  return Container(
    width: 343,
    height: 36,
    margin: const EdgeInsets.symmetric(vertical: 5),
    decoration:  ShapeDecoration(
        color: Colors.black.withOpacity(0.15),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        )
    ),
    alignment: Alignment.center,
    child:  GestureDetector(
      onTap: (){
        onTap();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 7),
            child: Icon(Icons.search,color: iconColor,),
          ),
          Text("搜索",style: TextStyle(fontSize: 16,color: Colors.black.withOpacity(0.45)),),
        ],
      ),
    ),
  );
}