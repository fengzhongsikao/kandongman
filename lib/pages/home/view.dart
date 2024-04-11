import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:extended_tabs/extended_tabs.dart';

import 'package:kandongman/widgets/button.dart';
import 'package:http/http.dart' as http;

import 'dart:developer';


import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;


final lengthProvider = Provider<int>((ref) {
  return 3;
});

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends ConsumerState<Home>
    with SingleTickerProviderStateMixin {
  late final AutoDisposeProvider<TabController>
      recentWatchScreenTabStateTestProvider;

  @override
  void initState() {
    recentWatchScreenTabStateTestProvider = Provider.autoDispose(
      (ref) => TabController(
        length: ref.watch(lengthProvider),
        vsync: this,
      ),
    );
    super.initState();
    fetch();
  }

  List tabs = ["推荐", "日漫", "国漫"];

  var hotList=<String,String>{};

  @override
  Widget build(BuildContext context) {
    final tabController = ref.watch(recentWatchScreenTabStateTestProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "爱动漫",
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
        ),
      ),
      body: _body(),
      // bottomNavigationBar: _bottom(context),
    );
  }

  _body() {
    final tabController = ref.watch(recentWatchScreenTabStateTestProvider);
    return TabBarView(controller: tabController, children: [
      hotList.isNotEmpty?
      GridView.builder(
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.6,
          ),
          itemCount: hotList.keys.length,
          itemBuilder: (_, int index) {
            var keys=hotList.keys.toList();
            return gridList(keys,index);
          }):const Center(child: CircularProgressIndicator()),

      // Container(
      //   child: Column(
      //     children: [
      //       myCustomButton(
      //         onTap: () async {
      //           await fetch();
      //         },
      //         title: "点击",
      //         width: 100,
      //         height: 50,
      //       ),
      //     ],
      //   ),
      // ),
      Container(
        child: Text("sdsdsd2"),
      ),
      Container(
        child: Text("sdsdsd3"),
      ),
    ]);
  }

  gridList(List<String> keys,int index){
    return Container(
      color: Colors.yellow,
      width: 100,
      height: 100,
      child: Column(
        children: [
          Text("asas"),
        ],
      ),
    );
  }


  Future<void> fetch() async {
    String urlString = 'https://9ciyuan.com';
    Uri uri = Uri.parse(urlString);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      // 请求成功，打印响应内容
      log("hahah------${response.body}");
      var document = parser.parse(response.body);
      List<dom.Element> liTags=document.getElementsByClassName('swiper-wrapper');
      for (var li in liTags) {
        List<dom.Element> divs= li.querySelectorAll('div');
        for (var div in divs) {
          if (div.classes.contains('pic')) {
            var picDiv=div.querySelector("a")?.querySelector("div");
            var name=div.querySelector("a")?.attributes['title'];
            print("div------${picDiv?.attributes['data-background']}");
            var hotUrl=picDiv?.attributes['data-background'];
            hotList['$name']=hotUrl!;
          }
        }

      }
    }
  }
}
