import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:elearning/screens/bottom_navigation_page.dart';
import 'package:elearning/screens/login_page.dart';
import 'package:elearning/screens/home_page.dart';
import 'package:elearning/screens/settings_page.dart';

class NavigationManager {
  factory NavigationManager() {
    return _instance;
  }

  static final NavigationManager _instance = NavigationManager._internal();

  static NavigationManager get instance => _instance;

  static late final GoRouter router;

  static final GlobalKey<NavigatorState> parentNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> homeTabNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> settingsTabNavigatorKey =
      GlobalKey<NavigatorState>();

  NavigationManager._internal() {
    final routes = [
      GoRoute(
        path: loginPath,
        pageBuilder: (context, GoRouterState state) {
          return getPage(
            child: const LoginPage(),
            state: state,
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: parentNavigatorKey,
        branches: _onlineRoutes(),
        pageBuilder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          return getPage(
            child: BottomNavigationPage(child: navigationShell),
            state: state,
          );
        },
      ),
    ];

    router = GoRouter(
      navigatorKey: parentNavigatorKey,
      initialLocation: loginPath,
      routes: routes,
    );
  }

  static Page getPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }

  static const String loginPath = '/login';
  static const String homePath = '/home';
  static const String settingsPath = '/settings';

  List<StatefulShellBranch> _onlineRoutes() {
    return [
      StatefulShellBranch(
        navigatorKey: homeTabNavigatorKey,
        routes: [
          GoRoute(
            path: homePath,
            pageBuilder: (context, GoRouterState state) {
              return getPage(
                child: const HomePage(),
                state: state,
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: settingsTabNavigatorKey,
        routes: [
          GoRoute(
            path: settingsPath,
            pageBuilder: (context, GoRouterState state) {
              return getPage(
                child: const SettingsPage(),
                state: state,
              );
            },
          ),
        ],
      ),
    ];
  }
}
