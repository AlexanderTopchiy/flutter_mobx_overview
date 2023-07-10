import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mobx_overview/data/model/user.dart';
import 'package:flutter_mobx_overview/feature/common/component/card_list.dart';
import 'package:flutter_mobx_overview/feature/user/mobx/user_store.dart';
import 'package:flutter_mobx_overview/generated/l10n.dart';
import 'package:mobx/mobx.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late final UserStore userStore;

  @override
  void initState() {
    super.initState();
    userStore = UserStore()..fetchUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.users),
      ),
      body: RefreshIndicator(
        onRefresh: () async => userStore.fetchUserList(),
        child: Observer(
          builder: (_) => switch (userStore.userListFuture.status) {
            FutureStatus.pending => const Center(child: CircularProgressIndicator()),
            FutureStatus.fulfilled => CardList<User>(itemList: userStore.userListFuture.result),
            FutureStatus.rejected => Center(child: Text(S.current.networkError)),
          },
        ),
      ),
    );
  }
}
