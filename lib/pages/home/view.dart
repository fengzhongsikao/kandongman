import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:extended_tabs/extended_tabs.dart';
import 'package:kandongman/pages/home/state.dart';

import 'package:kandongman/widgets/button.dart';

import 'dart:developer';
import 'package:extended_image/extended_image.dart';
import 'package:kandongman/widgets/search.dart';


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
        centerTitle: true,
        title: searchBoxLess(onTap: () {}, iconColor: Colors.grey),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Column(
          children: [
            TabBar(
              controller: tabController,
              tabs: tabs.map((e) => Tab(text: e)).toList(),
            )
          ],
        ),),
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
            childAspectRatio: 0.9,
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
   var hotList = ref.read(hotListProvider);
    return Container(
      color: Colors.white,
      width: 100,
      height: 150,
      child: Column(
        children: [
           GestureDetector(
             onTap: (){
               // context.pushReplacement('/home/videoDetails');
               var router=GoRouter.of(context);
               print("------${context.runtimeType}");
               print("------${router.runtimeType}");
               router.pushNamed('videoDetails');
             },
             child: Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.symmetric(horizontal: 2,vertical: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                    child:ExtendedImage.network(
                      hotList.value![keys[index]]!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                      cache: true,
                      border: Border.all(color: Colors.white, width: 1.0),
                      // borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      //cancelToken: cancellationToken,
                    ),
                    // Image.network(hotList.value![keys[index]]!,fit: BoxFit.fitWidth,),),),
              ),
             ),
           ),
          Text(keys[index]),
        ],
      ),
    );
  }
}
