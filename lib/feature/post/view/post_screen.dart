import 'package:flutter/material.dart';
import 'package:flutter_mobx_overview/generated/l10n.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.posts),
      ),
      body: const Placeholder(),
    );
  }
}
