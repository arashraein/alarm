import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'alarm_page.dart';
import 'app_scaffold.dart';
import 'const.dart';
import 'navigation_provider.dart';
import 'notification_service.dart';
import 'themes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().requestPermissions();
  await NotificationService().init();
  runApp(
    ChangeNotifierProvider(
      create: (_) => NavigationProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ShadApp.custom(
        theme: buildShadTheme(),
        darkTheme: buildShadTheme(),
        themeMode: ThemeMode.light,
        appBuilder: (context) => CupertinoApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          theme: buildCupertinoTheme(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],
          builder: (context, child) {
            cnTextTheme = ShadTheme.of(context).textTheme;

            return ShadAppBuilder(child: child!);
          },
          home: const AppScaffold(),
          routes: <String, WidgetBuilder>{
            '/alarm': (BuildContext context) => const AlarmPage(),
          },
        ),
      );
}
