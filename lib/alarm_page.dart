import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 40),
              ShadButton(
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
      );
}
