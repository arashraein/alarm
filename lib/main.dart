import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'alarm_page.dart';
import 'home_page.dart';
import 'notification_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ShadApp.custom(
        themeMode: ThemeMode.light,
        darkTheme: ShadThemeData(
          brightness: Brightness.dark,
          colorScheme: const ShadSlateColorScheme.dark(),
        ),
        appBuilder: (BuildContext context) => CupertinoApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Alarm',
          home: const HomePage(),
          routes: <String, WidgetBuilder>{
            '/alarm': (BuildContext context) => const AlarmPage(),
          },
        ),
      );
}
