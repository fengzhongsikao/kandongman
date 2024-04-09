import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClassificationPage extends ConsumerWidget {
  const ClassificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("分类"),
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
