import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


/// @Description :
/// @Author : fong
/// @Date:  2024/4/12  12:39


class SearchPage extends ConsumerWidget {
   SearchPage({super.key});

  final textController=TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,size: 18,),
          onPressed: (){
            var router=GoRouter.of(context);
            router.pop();
          },
        ),
        title: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
            ),
          controller:textController ,
        ),
      ),
        body: _body(),
    );
  }

  _body(){
    return SafeArea(
      child: ListView.builder(
        itemCount: 10,
          itemBuilder: (_,index){
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          width: double.infinity,
          color: const Color.fromRGBO(244, 244, 244, 1),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    "https://tse1-mm.cn.bing.net/th/id/OIP-C.PxTQQN6hn2OQeAx3A1YoygHaDt?rs=1&pid=ImgDetMain",
                    width: 50,
                    height:100,
                    fit: BoxFit.contain,
                  ),
                ),
                Text("asdd"),
              ],
            ),
          ),
        );
      }),
    );
  }
}
