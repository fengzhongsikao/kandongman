import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// @Description :
/// @Author : fong
/// @Date:  2024/4/12  12:39


class VideoDetailsPage extends ConsumerWidget {
  const VideoDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("sdsdsd"),
        // ),
        body: _body(),
    );
  }

  _body(){
    return Container();
  }


}
