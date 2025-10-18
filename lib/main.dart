import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'alarm_page.dart';
import 'const.dart';
import 'home_page.dart';
import 'notification_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().requestPermissions();
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
        appBuilder: (context) => CupertinoApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          theme: CupertinoTheme.of(context),
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
          home: const HomePage(),
          routes: <String, WidgetBuilder>{
            '/alarm': (BuildContext context) => const AlarmPage(),
          },
        ),
      );
}
