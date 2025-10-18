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
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _fadeAnimation = FadeTransition(
      opacity: _controller,
      child: const Text(
        'Time to wake up!',
        style: TextStyle(fontSize: 24),
      ),
    ).opacity;
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Alarm'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'Wake Up Man',
                    style: ShadTheme.of(context).textTheme.h3,
                  )),
              const SizedBox(height: 40),
              ScaleTransition(
                scale: _scaleAnimation,
                child: ShadButton(
                  onPressed: () {
                    NotificationService().cancelAllNotifications();
                    // Navigate back to the home page
                    Navigator.pop(context);
                  },
                  child: const Text('Stop Alarm'),
                ),
              ),
            ],
          ),
        ),
      );
}
