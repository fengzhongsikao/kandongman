import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;

part 'state.g.dart';

@riverpod
Future<Map<String, String>> HotList(HotListRef ref) async {
   String urlString = 'https://9ciyuan.com';
    Uri uri = Uri.parse(urlString);
    var hotList=<String,String>{};
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      // 请求成功，打印响应内容
      // log("hahah------${response.body}");
      var document = parser.parse(response.body);
      List<dom.Element> liTags =
          document.getElementsByClassName('swiper-wrapper');
      for (var li in liTags) {
        List<dom.Element> divs = li.querySelectorAll('div');
        for (var div in divs) {
          if (div.classes.contains('pic')) {
            var picDiv = div.querySelector("a")?.querySelector("div");
            var name = div.querySelector("a")?.attributes['title'];
            // print("div------${picDiv?.attributes['data-background']}");
            var hotUrl = picDiv?.attributes['data-background'];
            hotList['$name'] = hotUrl!;
          }
        }
      }
    }
  return hotList;
}
