import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../data/providers/navigation_provider.dart';
import '../home/home_page.dart';
import '../nfc/nfc_page.dart';
import '../settings/settings_page.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key});

  @override
  Widget build(BuildContext context) => CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.tags),
              label: 'NFC',
            ),
          ],
          onTap: (index) {
            Provider.of<NavigationProvider>(context, listen: false)
                .selectedIndex = index;
          },
        ),
        tabBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (context) => const HomePage(),
              );
            case 1:
              return CupertinoTabView(
                builder: (context) => const SettingsPage(),
              );
            case 2:
              return CupertinoTabView(
                builder: (context) => const NfcPage(),
              );
            default:
              return CupertinoTabView(
                builder: (context) => const HomePage(),
              );
          }
        },
      );
}
