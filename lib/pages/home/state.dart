import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state.g.dart';

String url= 'http://192.168.31.170:8000/hot';
// String url= 'http://172.18.0.163:8000';
var hotList2=<HotMovie>[];
final dio = Dio();


@riverpod
Future<List<HotMovie>> hotList(HotListRef ref) async {

  try{
    final response = await dio.get("$url/hot",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ));
    var myList=response.data;
    for (var i = 0; i < myList.length; i++) {
      var temp=HotMovie(cover: myList[i]['cover'], rate: myList[i]['rate'], title: myList[i]['title']);
      hotList2.add(temp);
    }
  }
  catch(e){
    if (kDebugMode) {
      print("--------错误-----------$e");
    }
  }

  return hotList2;
}

class HotMovie{
  String? cover;
  String? rate;
  String? title;
  HotMovie({required this.cover,required this.rate,required this.title});
}
