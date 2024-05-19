import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kandongman/pages/home/state.dart';

import 'package:kandongman/widgets/button.dart';

import 'dart:developer';
import 'package:kandongman/widgets/search.dart';


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
        centerTitle: true,
        title: searchBoxLess(onTap: () {
          var router=GoRouter.of(context);
          router.pushNamed('search');
        }, iconColor: Colors.grey),
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

  _body()   {
    final tabController = ref.watch(recentWatchScreenTabStateTestProvider);

    final AsyncValue<List<HotMovie>> hotList2 =  ref.watch(hotListProvider);

    return Center(
      child: switch(hotList2){
        AsyncData(:final value) =>TabBarView(controller: tabController, children: [
            value.isNotEmpty?
            GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.8,
                ),
                itemCount: value.length,
                itemBuilder: (_, int index) {
                  var values = value[index];
                  return gridList(values, index);
                }):const Center(child: CircularProgressIndicator()),
            ///index.php/vod/detail/id/6059.html

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
              child: Text("没写"),
            ),
            Container(
              child: Text("没写"),
            ),
          ]),
        AsyncError() => const Text('Oops, something unexpected happened'),
        _ => const CircularProgressIndicator(),
      },
    );
  }

  gridList(HotMovie model, int index) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
           GestureDetector(
             onTap: (){
               var router=GoRouter.of(context);
               router.pushNamed('videoDetails',pathParameters:{"id":model.title!} );
             },
             child: Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.symmetric(horizontal: 2,vertical: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                    child:CachedNetworkImage(
                      // "${model.cover}",
                      httpHeaders: const {
                        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36 Edg/124.0.0.0',
                      },
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                      imageUrl: "${model.cover}",
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(Icons.error),
                      ),
                      //cancelToken: cancellationToken,
                    ),
                    // Image.network(hotList.value![keys[index]]!,fit: BoxFit.fitWidth,),),),
              ),
             ),
           ),
          Expanded(child: Text(model.title!,maxLines: 2,softWrap: true,overflow: TextOverflow.ellipsis,)),
        ],
      ),
    );
  }
}
