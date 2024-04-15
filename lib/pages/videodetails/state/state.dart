/// @Description :
/// @Author : fong
/// @Date:  2024/4/14  10:44


import 'dart:developer';


import 'package:kandongman/pages/videodetails/movie/MovieDetail.dart';
import 'package:xpath_selector_html_parser/xpath_selector_html_parser.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;


part 'state.g.dart';

@riverpod
Future<MovieDetail> movieDetail(MovieDetailRef ref,{required String url})  async {
  MovieDetail movieInfo = MovieDetail(
      title: '',
      image: '',
      category: '',
      region: '',
      year: '',
      director: '',
      protagonist: '',
      status: '',
      briefIntroduction: '',
      contentIntroduction: '',
      total: 1,
  );
  if(url.isNotEmpty){
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      log("hahah------${response.body}");
      
      var document = parser.parse(response.body);

      final html2 = HtmlXPath.node(document);


      var totalNode=html2.queryXPath("/html/body/div[4]/div[2]/div[1]/div[1]/div[1]/div[1]/ul/li/span");
      movieInfo.total=int.parse(totalNode.node!.text.toString());

      movieInfo.image=html2.queryXPath("/html/body/div[4]/div[1]/div[1]/img").node!.attributes['data-original']!;


      var category="";
      var categoryLength=html2.queryXPath("/html/body/div[4]/div[1]/div[2]/p/span[1]/a").node?.children.length;
      for(int i = 1; i <=categoryLength!; i++) {
        if(i>1){
          category+=" ${html2.queryXPath("/html/body/div[4]/div[1]/div[2]/p/span[1]").node?.children[i]}";
        }else{
          category+="${html2.queryXPath("/html/body/div[4]/div[1]/div[2]/p/span[1]").node?.children[i]}";
        }
      }
      movieInfo.category=category;
      // print("--node----${html2.queryXPath("/html/body/div[4]/div[1]/div[2]/p/span[1]").node}");
      // print("--children----${html2.queryXPath("/html/body/div[4]/div[1]/div[2]/p/span[1]").node?.children}");
      // print("--node?----${html2.query("/html/body/div[4]/div[1]/div[2]/p/span[1]").node?.children[0].node.text}");
      // print("--etxt----${html2.queryXPath("/html/body/div[4]/div[1]/div[2]/p/span[1]/a[0]").node?.text}");


      movieInfo.region=html2.queryXPath("/html/body/div[4]/div[1]/div[2]/p/span[2]/a").node!.text!;
      movieInfo.year=html2.queryXPath("/html/body/div[4]/div[1]/div[2]/p/span[3]/a/text()").node!.text!;
      movieInfo.director=html2.queryXPath("/html/body/div[4]/div[1]/div[2]/p/span[4]/a/text()").node!.text!;


     var protagonistLength=html2.query("/html/body/div[4]/div[1]/div[2]/p/span[5]").node?.children.length;
     var protagonist="";
     for(int i = 1; i <=protagonistLength!; i++) {
       if(i>1){
         protagonist+=" ${html2.queryXPath('/html/body/div[4]/div[1]/div[2]/p/span[5]/a[$i])').node?.text}";
       }else{
         protagonist+="${html2.queryXPath('/html/body/div[4]/div[1]/div[2]/p/span[5]/a[$i])').node?.text}";
       }
     }
     movieInfo.protagonist=protagonist.trim();
     movieInfo.status=html2.queryXPath('/html/body/div[4]/div[1]/div[2]/p/span[6]/text()').node!.text!;
     movieInfo.briefIntroduction=html2.queryXPath('/html/body/div[4]/div[1]/div[2]/div[1])').node!.text!;
     // movieInfo.contentIntroduction=html2.query('/html/body/div[4]/div[2]/div[1]/div[2]/div/p').node!.text.toString();
     // var b=html2.queryXPath('/html/body/div[4]/div[2]/div[1]/div[2]/div');
     
     var contentIntroduction=document.getElementsByClassName("vod-list")[0]..querySelector('div')!.querySelector('p')?.text;
     print("contentIntroduction------${contentIntroduction}");
     movieInfo.contentIntroduction=contentIntroduction.toString();

     // var c=b?.queryXPath('/p');
     // print("c------${c}");

     ///html/body/div[4]/div[2]/div[1]/div[2]/div/p

      List<dom.Element> infos= document.getElementsByClassName('info');

      for(var a in infos){
        movieInfo.title=a.querySelector('h3')!.text.trim();
      }
    }

    
  }
  
  return movieInfo;

}

class $i {
}

