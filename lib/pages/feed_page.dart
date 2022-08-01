import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final result = await Routemaster.of(context)
                        .push<String?>('profile/1')
                        .result;

                    if (kDebugMode) {
                      print("Profile result: '$result'");
                    }
                  },
                  child: const Text('Push profile page with ID 1'),
                ),
                ElevatedButton(
                  onPressed: () => Routemaster.of(context)
                      .push('profile/2?message=hello&abbas=abbas'),
                  child: const Text(
                      'Push profile page with ID 2 and query string'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      Routemaster.of(context).push('profile/1/photo'),
                  child:
                      const Text("Go to user 1's photo page (skipping stacks)"),
                ),
                ElevatedButton(
                  onPressed: () => Routemaster.of(context).push('profile/3'),
                  child: const Text('Go to user 3 (validation fail)'),
                ),
                ElevatedButton(
                  onPressed: () => Routemaster.of(context).push('/404'),
                  child: const Text('Go to /404'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      Routemaster.of(context).push('/bottom-navigation-bar'),
                  child: const Text('Bottom Navigation Bar page'),
                ),
                ElevatedButton(
                  onPressed: () => Routemaster.of(context)
                      .replace('/bottom-navigation-bar-replace'),
                  child: const Text('Replace test'),
                ),
                ElevatedButton(
                  onPressed: () => Routemaster.of(context).push('/settings'),
                  child: const Text('Jump to settings tab'),
                ),
                ElevatedButton(
                  onPressed: () => Routemaster.of(context).push('/tab-bar'),
                  child: const Text('Tab bar page'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      Routemaster.of(context).push('/custom-transitions'),
                  child: const Text('Custom transition page'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return Scaffold(
                        appBar: AppBar(),
                        body: const Center(child: Text('Non-Page route')),
                      );
                    }),
                  ),
                  child: const Text('Push non-Page route'),
                ),
                ElevatedButton(
                  onPressed: () => Routemaster.of(context).push('/stack'),
                  child: const Text('/stack'),
                ),
                ElevatedButton(
                  onPressed: () => Routemaster.of(context).push('/stack/one'),
                  child: const Text('/stack/one'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      Routemaster.of(context).push('/stack/one/two'),
                  child: const Text('/stack/one/two'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final String? id;
  final String? message;
  final String? abbas;

  const ProfilePage({
    Key? key,
    required this.id,
    required this.message,
    required this.abbas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Profile page, ID = $id, message = $message'),
            Text(
                'Profile page - ${RouteData.of(context).pathParameters['id']!}'),
            ElevatedButton(
              onPressed: () => Routemaster.of(context).push('photo'),
              child: const Text('Photo page (custom animation)'),
            ),
            ElevatedButton(
              onPressed: () => Routemaster.of(context).push('/feed/profile/2'),
              child: const Text('Go to profile page 2'),
            ),
            ElevatedButton(
              onPressed: () => Routemaster.of(context).history.back(),
              child: const Text('Back'),
            ),
            ElevatedButton(
              onPressed: () => Routemaster.of(context).pop(),
              child: const Text('Pop'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop('hello!'),
              child: const Text('Return Navigator value'),
            ),
            ElevatedButton(
              onPressed: () => Routemaster.of(context).pop('hello!'),
              child: const Text('Return Routemaster value'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: const Text('Return null Navigator value'),
            ),
            ElevatedButton(
              onPressed: () => Routemaster.of(context).pop(null),
              child: const Text('Return null Routemaster value'),
            ),
          ],
        ),
      ),
    );
  }
}

class PhotoPage extends StatelessWidget {
  final String? id;

  const PhotoPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This would be a lovely picture of user $id'),
            ElevatedButton(
              onPressed: () => Routemaster.of(context).pop(),
              child: const Text('Back'),
            ),
            ElevatedButton(
              onPressed: () => Routemaster.of(context).popUntil(
                (routeData) => routeData.path == '/',
              ),
              child: const Text('Pop until root'),
            ),
          ],
        ),
      ),
    );
  }
}
