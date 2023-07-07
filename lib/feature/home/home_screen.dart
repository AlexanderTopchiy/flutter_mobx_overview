import 'package:flutter/material.dart';
import 'package:flutter_mobx_overview/generated/l10n.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const HomeScreen({
    super.key,
    required this.navigationShell,
  });

  static final _tabs = [
    NavigationDestination(
      label: S.current.users,
      icon: const Icon(Icons.person),
    ),
    NavigationDestination(
      label: S.current.posts,
      icon: const Icon(Icons.message),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: _tabs,
        onDestinationSelected: _goBranch,
      ),
    );
  }

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
