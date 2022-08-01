import 'package:e_shopping/app_state/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabState = CupertinoTabPage.of(context);
    final appState = Provider.of<AppState>(context);

    return CupertinoTabScaffold(
      controller: tabState.controller,
      tabBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            label: 'Feed',
            icon: Icon(CupertinoIcons.list_bullet),
          ),
          const BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(CupertinoIcons.search),
          ),
          if (appState.showBonusTab)
            const BottomNavigationBarItem(
              label: 'Bonus!',
              icon: Icon(CupertinoIcons.exclamationmark),
            ),
          const BottomNavigationBarItem(
            label: 'Notifications',
            icon: Icon(CupertinoIcons.bell),
          ),
          const BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(CupertinoIcons.settings),
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return HeroControllerScope(
          controller: MaterialApp.createMaterialHeroController(),
          child: PageStackNavigator(
            key: ValueKey(tabState.page.paths[index]),
            stack: tabState.stacks[index],
          ),
        );
      },
    );
  }
}
