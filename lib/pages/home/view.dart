import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:extended_tabs/extended_tabs.dart';

import 'package:kandongman/widgets/button.dart';
import 'package:http/http.dart' as http;
// import 'dart:html';

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
  }

  List tabs = ["推荐", "日漫", "国漫"];

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
      Container(
        child: Column(
          children: [
            myCustomButton(
              onTap: () async {
                var url = Uri.https('https://9ciyuan.com');
                var response = await http.get(url);
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');

                // print(await http.read(Uri.https('example.com', 'foobar.txt')));
                // var response = await http.get('xxx.html');
                // Document document = parse(response.body);
                // print("aaaa----${document}");
              },
              title: "点击",
              width: 100,
              height: 50,
            ),
          ],
        ),
      ),
      Container(
        child: Text("sdsdsd2"),
      ),
      Container(
        child: Text("sdsdsd3"),
      ),
    ]);
  }
}
