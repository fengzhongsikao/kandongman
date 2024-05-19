import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kandongman/pages/mine/view.dart';
import 'package:kandongman/pages/search/view.dart';
import 'pages/Home/view.dart';
import 'package:go_router/go_router.dart';

import 'pages/classification/view.dart';
import 'pages/Main/view.dart';
import 'pages/videodetails/view.dart';

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
                },

            ),
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
                return const MinePage();
              }),
        ]),
      ],
    ),
    GoRoute(
      name: 'videoDetails', // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/home/videoDetails/:id',
      builder: (context, state){
        final href = state.pathParameters['id'];
        return VideoDetailsPage(id: href);
      } ,
    ),
    GoRoute(
      name: 'search', // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/home/search',
      builder: (context, state){
        return SearchPage();
      } ,
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


