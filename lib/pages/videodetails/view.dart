import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'movie/MovieDetail.dart';
import 'state/state.dart';

/// @Description :
/// @Author : fong
/// @Date:  2024/4/12  12:39


class VideoDetailsPage extends ConsumerWidget {
  final String? href;
  const VideoDetailsPage({super.key,required this.href});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
        body: _body(ref),
    );
  }

  _body(WidgetRef ref){

    var a=ref.watch(movieDetailProvider(url: href!));

    // print("------${a.runtimeType}");
    // print("------${a}");
    // print("------${a.toString().isEmpty}");
    print("---tojson---${a.value?.toJson()}");

    return SafeArea(
      child: Container(
        child:Column(
          children: [
            Container(
              height: 400,
              color: Colors.white,
              child: Container(),
            ),
            // Text("${a.value?.title}"),
            Text("${href}"),
          ],
        ) ,
      ),
    );
  }
}
