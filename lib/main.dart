import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kandongman/pages/My/view.dart';
import 'pages/Home/view.dart';
import 'package:go_router/go_router.dart';

import 'pages/classification/view.dart';
import 'pages/Main/view.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final _sectionNavigatorKey = GlobalKey<NavigatorState>();
final _rootNavigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainPage(navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _sectionNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
                name: 'home',
                path: '/home',
                builder: (context, state) {
                  return const Home();
                }),
          ],
        ),
        StatefulShellBranch(routes: <RouteBase>[
          GoRoute(
              name: 'classification',
              path: '/classification',
              builder: (context, state) {
                return const ClassificationPage();
              }),
        ]),
        StatefulShellBranch(routes: <RouteBase>[
          GoRoute(
              name: 'mine',
              path: '/mine',
              builder: (context, state) {
                return const MyPage();
              }),
        ]),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
