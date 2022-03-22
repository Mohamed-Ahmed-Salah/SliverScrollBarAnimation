import 'package:first_flutter_challenge/models/MyHeader.dart';
import 'package:first_flutter_challenge/widgets/get_box_offset.dart';
import 'package:flutter/material.dart';

import '../controller/sliver_scroll_controller.dart';

class ListItemHeaderSliver extends StatelessWidget {
  final SliverScrollController bloc;

  const ListItemHeaderSliver({Key? key, required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemOffset=bloc.listOffsetItemHeader;
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(

          children: List.generate(bloc.listCategory.length, (index) {
            return ValueListenableBuilder(
              valueListenable: bloc.headerNotifier,
              builder: (_,MyHeader? value, __) {
                return GetBoxOffset(
                  offset: ((offset)=> itemOffset[index]=offset.dx),
                  child: InkWell(
                    onTap: (){
                     // print("text");
                      bloc.scrollOnTap(index);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: index == value?.index ? Colors.white : null,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          bloc.listCategory[index].category,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: index == value?.index ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            );
          }),
        ),
      ),
    );
  }
}
