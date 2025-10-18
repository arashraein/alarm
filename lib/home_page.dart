import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'notification_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TimeOfDay? _selectedTime;
  late final Timer _timer;
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
        const Duration(seconds: 1), (Timer timer) => _updateCurrentTime());
    _updateCurrentTime();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateCurrentTime() {
    setState(() {
      _currentTime = _formatDateTime(DateTime.now());
    });
  }

  String _formatDateTime(DateTime dateTime) =>
      DateFormat('hh:mm:ss a').format(dateTime);

  Future<void> _setAlarm() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
      _scheduleAlarm();
    }
  }

  void _scheduleAlarm() {
    if (_selectedTime != null) {
      final DateTime now = DateTime.now();
      DateTime scheduledDate = DateTime(now.year, now.month, now.day,
          _selectedTime!.hour, _selectedTime!.minute);
      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }
      NotificationService().scheduleAlarm(
        scheduledDate,
        'Alarm',
        'Time to wake up!',
      );
    }
  }

  void _cancelAlarm() {
    NotificationService().cancelAllNotifications();
    setState(() {
      _selectedTime = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ShadTextTheme textTheme = ShadTheme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Alarm'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _currentTime,
              style: ShadTheme.of(context).textTheme.h3,
            ),
            const SizedBox(height: 40),
            ShadCard(
              child: Column(
                children: [
                  Text(
                    _selectedTime != null
                        ? 'Alarm set for ${_selectedTime!.format(context)}'
                        : 'No alarm set',
                    style: textTheme.h4,
                  ),
                  const SizedBox(height: 20),
                  ShadButton(
                    onPressed: _setAlarm,
                    child: const Text('Set Alarm'),
                  ),
                  const SizedBox(height: 10),
                  ShadButton(
                    onPressed: _cancelAlarm,
                    child: const Text('Cancel Alarm'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
