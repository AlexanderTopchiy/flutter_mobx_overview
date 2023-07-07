import 'package:flutter/material.dart';
import 'package:flutter_mobx_overview/feature/common/component/card_item.dart';
import 'package:flutter_mobx_overview/data/model/post.dart';
import 'package:flutter_mobx_overview/data/model/user.dart';

class CardList<Object> extends StatelessWidget {
  final List<Object> itemList;

  const CardList({
    super.key,
    required this.itemList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemBuilder: (_, index) {
        final item = switch (Object) {
          User => CardItem(item: itemList[index] as User),
          Post => CardItem(item: itemList[index] as Post),
          _ => const SizedBox(),
        };

        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(top: 24),
            child: item,
          );
        }

        if (index == itemList.length - 1) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: item,
          );
        }

        return item;
      },
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemCount: itemList.length,
    );
  }
}
