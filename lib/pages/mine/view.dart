import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MinePage extends ConsumerWidget {
  const MinePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      child: Text("asas"),
    );
  }
}
