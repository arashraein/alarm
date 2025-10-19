import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'const.dart';
import 'notification_service.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ShadCard(
                  width: 350,
                  child: Center(
                    child: Text(
                      'Your Alarm Is Ringing',
                      style: cnTextTheme.h4,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ShadButton.destructive(
                  onPressed: () {
                    NotificationService().cancelAllNotifications();
                    // Navigate back to the home page
                    Navigator.pop(context);
                  },
                  child: const Text('Stop Alarm'),
                ),
              ],
            ),
          ),
        ),
      );
}
