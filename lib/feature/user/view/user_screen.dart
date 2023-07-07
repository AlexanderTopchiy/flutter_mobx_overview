import 'package:flutter/material.dart';
import 'package:flutter_mobx_overview/generated/l10n.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.users),
      ),
      body: const Placeholder(),
    );
  }
}
