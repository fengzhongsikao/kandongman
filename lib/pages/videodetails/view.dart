import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'dart:core';

import 'movie/MovieDetail.dart';
import 'state/state.dart';

/// @Description :
/// @Author : fong
/// @Date:  2024/4/12  12:39


class VideoDetailsPage extends ConsumerWidget {
  final String? id;
   VideoDetailsPage({super.key,required this.id});
  FijkPlayer player = FijkPlayer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
        body: _body(ref),
    );
  }

  _body(WidgetRef ref){
    final AsyncValue<ReturnSearchInfo> searchInfo =ref.watch(searchInfoProvider);

    return SafeArea(
      child: Center(
        child: searchInfo.when(data: (value){


          // player.setDataSource(urlListNew, autoPlay: true);
          return Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                alignment: Alignment.center,
                child: FijkView(
                  color: Colors.black,
                  player: player,
                ),
              ),
              // SizedBox(
              //     width: double.infinity,
              //     child: Padding(
              //       padding: const EdgeInsets.all(4.0),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             widget.data["标题"][widget.pos],
              //             style: const TextStyle(
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 20,
              //                 color: Colors.black),
              //             //textAlign: TextAlign.left,
              //           ),
              //           Text(
              //             widget.data["副标题"][widget.pos],
              //             //textAlign: TextAlign.left,
              //           ),
              //           GestureDetector(
              //             onTap: () {
              //               showDialog<void>(
              //                   context: context,
              //                   barrierDismissible: false,
              //                   builder: (BuildContext context) {
              //                     return AlertDialog(
              //                       title: const Text('简介'),
              //                       content: SingleChildScrollView(
              //                         child: ListBody(
              //                           children: <Widget>[
              //                             Text(brief),
              //                           ],
              //                         ),
              //                       ),
              //                       actions: <Widget>[
              //                         TextButton(
              //                           child: const Text('确定'),
              //                           onPressed: () {
              //                             Navigator.of(context).pop();
              //                           },
              //                         ),
              //                       ],
              //                     );
              //                   });
              //             },
              //             child: Text(
              //               maxLines: 5,
              //               overflow: TextOverflow.ellipsis,
              //               brief,
              //               //textAlign: TextAlign.left,
              //             ),
              //           )
              //         ],
              //       ),
              //     )),
              // TabBar(
              //     tabAlignment: TabAlignment.start,
              //     controller: _tabController,
              //     isScrollable: true,
              //     tabs: const [
              //       Tab(
              //         text: 'M3U8',
              //       ),
              //     ]),
              // Expanded(
              //   child: GridView.builder(
              //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //         childAspectRatio: 2.7,
              //         crossAxisCount: 3,
              //       ),
              //       itemCount: urlListNew.length,
              //       itemBuilder: (BuildContext context, int index) {
              //         return Padding(
              //           padding: const EdgeInsets.all(4.0),
              //           child: OutlinedButton.icon(
              //               icon: currentCollection == index
              //                   ? const Icon(Icons.check)
              //                   : const SizedBox.shrink(),
              //               onPressed: () async {
              //                 if (currentCollection != index) {
              //                   await player.reset();
              //                   player.setDataSource(urlListNew[index],
              //                       autoPlay: true);
              //                   setState(() {
              //                     currentCollection = index;
              //                   });
              //                 }
              //               },
              //               label: Text("第${index + 1}集")),
              //         );
              //       }),
              // ),
            ],
          );

        }, error: (err,stack){
         return Text("---$err");
        }, loading: (){
          return const CircularProgressIndicator();
        }),
    )
    );
  }
}
