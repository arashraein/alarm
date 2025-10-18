import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      _currentTime = DateFormat('hh:mm:ss a').format(DateTime.now());
    });
  }

  Future<void> _setAlarm(TimeOfDay time) async {
    setState(() {
      _selectedTime = time;
    });
    _scheduleAlarm();
  }

  void _showTimePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        TimeOfDay tempTime = _selectedTime ?? TimeOfDay.now();
        return Container(
          color: CupertinoColors.systemBackground.resolveFrom(context),
          height: 250,
          child: Column(
            children: [
              Expanded(
                child: CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.hm,
                  initialTimerDuration: Duration(
                    hours: tempTime.hour,
                    minutes: tempTime.minute,
                  ),
                  onTimerDurationChanged: (Duration newDuration) {
                    tempTime = TimeOfDay(
                      hour: newDuration.inHours,
                      minute: newDuration.inMinutes % 60,
                    );
                  },
                ),
              ),
              ShadButton(
                onPressed: () {
                  CupertinoApp.router().of.pop();
                  _setAlarm(tempTime);
                },
                child: const Text('Done'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
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
    final h4Style = textTheme.h4;
    return Scaffold(
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
                    style: h4Style,
                  ),
                  const SizedBox(height: 20),
                  ShadButton(
                    onPressed: _showTimePicker,
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
