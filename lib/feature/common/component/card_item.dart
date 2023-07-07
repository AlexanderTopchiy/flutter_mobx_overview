import 'package:flutter/material.dart';
import 'package:flutter_mobx_overview/data/model/post.dart';
import 'package:flutter_mobx_overview/data/model/user.dart';

class CardItem extends StatelessWidget {
  final Object item;

  const CardItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final tile = switch (item) {
      User(name: var name) => ListTile(
          title: Text(name),
        ),
      Post(title: var title, body: var body) => ListTile(
          title: Text(title),
          subtitle: Text(body),
        ),
      _ => const SizedBox(),
    };

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: tile,
    );
  }
}
