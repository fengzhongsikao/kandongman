import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;

part 'state.g.dart';

@riverpod
Future<Map<String, HotLists>> HotList(HotListRef ref) async {
   String urlString = 'https://9ciyuan.com';
    Uri uri = Uri.parse(urlString);
    var hotList=<String,HotLists>{};
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      var document = parser.parse(response.body);
      List<dom.Element> liTags =
          document.getElementsByClassName('swiper-wrapper');
      for (var li in liTags) {
        List<dom.Element> divs = li.querySelectorAll('div');
        for (var div in divs) {
          if (div.classes.contains('pic')) {
            var picDiv = div.querySelector("a")?.querySelector("div");
            var name = div.querySelector("a")?.attributes['title'];
            var href = div.querySelector("a")?.attributes['href'];
            var hotUrl = picDiv?.attributes['data-background'];
            hotList['$name'] = HotLists(hotImageUrl:hotUrl, href: urlString+href!, );
          }
        }
      }
    }
  return hotList;
}

class HotLists{
  String? hotImageUrl;
  String? href;
  HotLists({required this.hotImageUrl,required this.href});
}
