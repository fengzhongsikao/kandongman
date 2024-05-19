
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:kandongman/pages/home/state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state.g.dart';


@riverpod
Future<ReturnSearchInfo> searchInfo(SearchInfoRef ref)  async {
  var searchInfo = ReturnSearchInfo(title: '', pic: '', brief: '', playUrl: '', movieId: null, resourceLink: '');
  try{
    final response = await dio.get("$url/searchInto",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ));


    var temp=response.data;



    searchInfo = ReturnSearchInfo(
      title: temp['title'],
      pic: temp['pic'],
      brief: temp['brief'],
      playUrl: temp['playUrl'],
      movieId: temp['movieId'],
      resourceLink: temp['resourceLink'],
    );

  }
  catch(e){
    if (kDebugMode) {
      print("--------错误-----------$e");
    }
  }

  return searchInfo;

}

class ReturnSearchInfo{
  String? title;
  String? subTitle;
  String? pic;
  String? brief;
  String? playUrl;
  int? movieId;
  String resourceLink;

  ReturnSearchInfo({required this.title, required this.pic, required this.brief, required this.playUrl, required this.movieId,
    required this.resourceLink});
}