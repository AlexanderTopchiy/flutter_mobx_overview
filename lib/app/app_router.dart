import 'package:flutter/widgets.dart';
import 'package:flutter_mobx_overview/feature/home/home_screen.dart';
import 'package:flutter_mobx_overview/feature/post/view/post_screen.dart';
import 'package:flutter_mobx_overview/feature/user/view/user_screen.dart';
import 'package:go_router/go_router.dart';

abstract class _ScreenNames {
  static const home = 'home';
  static const userList = 'userList';
  static const postList = 'postList';
}

abstract class RoutesNames {
  static const home = '/${_ScreenNames.home}';
  static const userList = '$home/${_ScreenNames.userList}';
  static const postList = '$home/${_ScreenNames.postList}';
}

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _shellNavigatorUserKey = GlobalKey<NavigatorState>(debugLabel: 'userShell');
final _shellNavigatorPostKey = GlobalKey<NavigatorState>(debugLabel: 'postShell');

final appRouter = GoRouter(
  initialLocation: RoutesNames.userList,
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => HomeScreen(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorUserKey,
          routes: [
            GoRoute(
              path: RoutesNames.userList,
              pageBuilder: (_, __) => const NoTransitionPage(child: UserScreen()),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorPostKey,
          routes: [
            GoRoute(
              path: RoutesNames.postList,
              pageBuilder: (_, __) => const NoTransitionPage(child: PostScreen()),
            ),
          ],
        ),
      ],
    ),
  ],
);
