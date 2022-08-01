// This is the logged out route map.
// This only allows the user to navigate to the root path.
// Note: building the route map from methods allows hot reload to work
import 'package:e_shopping/app_state/app_state.dart';
import 'package:e_shopping/custom_page.dart';
import 'package:e_shopping/pages/bottom_navigation_bar_page.dart';
import 'package:e_shopping/pages/bottom_sheet.dart';
import 'package:e_shopping/pages/feed_page.dart';
import 'package:e_shopping/pages/home_page.dart';
import 'package:e_shopping/pages/notifications_page.dart';
import 'package:e_shopping/pages/search_page.dart';
import 'package:e_shopping/pages/settings_page.dart';
import 'package:e_shopping/pages/tab_bar_page.dart';
import 'package:e_shopping/screens/auth_screen.dart';
import 'package:e_shopping/widgets/fancy_animation.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRouteMap = RouteMap(
  onUnknownRoute: (route) => const Redirect('/'),
  routes: {
    '/': (_) => const MaterialPage(child: AuthScreen()),
  },
);

// This is the real route map - used if the user is logged in.
RouteMap buildRouteMap(
  // AppState appState
  ) {
  return RouteMap(
    routes: {
      '/': (_) => CupertinoTabPage(
            pageBuilder: (child) => MaterialWithModalsPage(child: child),
            child: const HomePage(),
            paths: [
              '/feed',
              '/search',
              // if (appState.showBonusTab) '/bonus',
              '/notifications',
              '/settings',
            ],
            backBehavior: TabBackBehavior.none,
          ),
      '/feed': (_) => const MaterialPage(
            name: 'Feed',
            child: FeedPage(),
          ),
      '/feed/profile/:id': (info) {
        if (info.pathParameters['id'] == '1' ||
            info.pathParameters['id'] == '2') {
          return MaterialPage(
            name: 'Profile',
            child: ProfilePage(
              id: info.pathParameters['id'],
              message: info.queryParameters['message'],
              abbas: info.queryParameters['abbas'],
            ),
          );
        }

        return const Redirect('/feed');
      },
      '/feed/profile/:id/photo': (info) => FancyAnimationPage(
            child: PhotoPage(id: info.pathParameters['id']),
          ),

      '/search': (_) => const MaterialPage(
            name: 'Search',
            child: SearchPage(),
          ),
      '/settings': (_) => const MaterialPage(
            name: 'Settings',
            child: SettingsPage(),
          ),

      // Most pages tend to appear only in one place in the app
      // However sometimes you can push them into multiple places.
      '/search/hero': (_) => const MaterialPage(child: HeroPage()),
      '/settings/hero': (_) => const MaterialPage(child: HeroPage()),

      // This gets really complicated to test out tested scenarios!
      '/notifications': (_) => const IndexedPage(
            child: NotificationsPage(),
            paths: ['one', 'two'],
          ),
      '/notifications/one': (_) => const MaterialPage(
            name: 'Notifications - One',
            child: NotificationsContentPage(
              message: 'Page one',
            ),
          ),
      '/notifications/two': (_) => const MaterialPage(
            name: 'Notifications - Two',
            child: NotificationsContentPage(message: 'Page two'),
          ),
      '/notifications/pushed': (_) => const MaterialPage(
            child: MessagePage(message: 'Pushed notifications'),
          ),
      '/tab-bar': (_) => TabPage(
            child: const TabBarPage(),
            paths: [
              'one',
              // if (appState.showBonusTab) 'bonus',
              'settings',
            ],
          ),
      '/tab-bar/one': (_) =>
          const MaterialPage(child: MessagePage(message: 'One')),
      '/tab-bar/bonus': (_) => const MaterialPage(
            child: MessagePage(message: 'BONUS!!'),
          ),
      '/tab-bar/settings': (_) => const MaterialPage(child: SettingsPage()),
      '/bottom-navigation-bar-replace': (_) => const MaterialPage(
            child: BottomNavigationBarReplacementPage(),
          ),
      '/bottom-navigation-bar': (_) => const IndexedPage(
            child: BottomNavigationBarPage(),
            paths: ['one', 'two', 'three'],
          ),
      '/bottom-navigation-bar/one': (_) => const MaterialPage(
            child: BottomContentPage(),
          ),
      '/bottom-navigation-bar/two': (_) => const MaterialPage(
            child: BottomContentPage2(),
          ),
      '/bottom-navigation-bar/three': (_) => const MaterialPage(
            child: MessagePage(message: 'Page three'),
          ),
      '/bottom-navigation-bar/threepage': (_) => const MaterialPage(
            child: DoubleBackPage(),
          ),
      '/bottom-navigation-bar/replaced': (_) => const MaterialPage(
            child: MessagePage(message: 'Replaced'),
          ),
      '/bonus': (_) => const MaterialPage(
            child: MessagePage(message: 'You found the bonus page!!!'),
          ),

      '/stack': (_) => StackPage(
            pageBuilder: (child) => BottomSheetPage(child: child),
            child: const StackBottomSheetContents(),
            defaultPath: 'one',
          ),

      '/stack/one': (_) => const MaterialPage(child: StackPageOne()),
      '/stack/one/two': (_) => const MaterialPage(child: StackPageTwo()),

      '/custom-transitions': (_) => CustomPage(
            child: const MessagePage(message: 'Custom transitions'),
          ),
      '/*': (_) => const MaterialPage(child: Text('error')),
    },
  );
}
