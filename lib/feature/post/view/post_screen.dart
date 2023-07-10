import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mobx_overview/data/model/post.dart';
import 'package:flutter_mobx_overview/feature/common/component/card_list.dart';
import 'package:flutter_mobx_overview/feature/post/mobx/post_store.dart';
import 'package:flutter_mobx_overview/generated/l10n.dart';
import 'package:mobx/mobx.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late final PostStore postStore;

  @override
  void initState() {
    super.initState();
    postStore = PostStore()..fetchPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.posts),
      ),
      body: RefreshIndicator(
        onRefresh: () async => postStore.fetchPostList(),
        child: Observer(
          builder: (_) => switch (postStore.postListFuture.status) {
            FutureStatus.pending => const Center(child: CircularProgressIndicator()),
            FutureStatus.fulfilled => CardList<Post>(itemList: postStore.postListFuture.result),
            FutureStatus.rejected => Center(child: Text(S.current.networkError)),
          },
        ),
      ),
    );
  }
}
