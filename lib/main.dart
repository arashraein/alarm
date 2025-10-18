import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Flutter Alarm',
        theme: ThemeData(
          primaryColor: const Color(0xFF8AB4F8),
          scaffoldBackgroundColor: const Color(0xFFF8F9FA),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(secondary: const Color(0xFFFDD835)),
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: const HomePage(),
        routes: <String, WidgetBuilder>{
          '/alarm': (BuildContext context) => const AlarmPage(),
        },
      );
}
