import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:extended_tabs/extended_tabs.dart';
import 'package:kandongman/pages/home/state.dart';

import 'package:kandongman/widgets/button.dart';

import 'dart:developer';


final lengthProvider = Provider<int>((ref) {
  return 3;
});

// final hotListProvider = StateProvider<Map<String, String>>((ref) => <String, String>{});

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends ConsumerState<Home>
    with SingleTickerProviderStateMixin {
  late final AutoDisposeProvider<TabController>
      recentWatchScreenTabStateTestProvider;

  // var hotList=<String,String>{};

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
    AsyncValue<Map<String, String>> hotList = ref.watch(hotListProvider);
    return TabBarView(controller: tabController, children: [


          // Text("${hotList.value.runtimeType}"),
      hotList.value!=null?
      GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.6,
          ),
          itemCount: hotList.value?.keys.length,
          itemBuilder: (_, int index) {
            var keys = hotList.value?.keys.toList();
            return gridList(keys!, index);
          }):const Center(child: CircularProgressIndicator()),
      //

      // Container(
      //   child: Column(
      //     children: [
      //       myCustomButton(
      //         onTap: () async {
      //
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

  gridList(List<String> keys, int index) {
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
}
