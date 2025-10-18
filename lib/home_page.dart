
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'notification_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TimeOfDay? _selectedTime;
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    _currentTime = _formatDateTime(DateTime.now());
  }


  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _setAlarm() {
    if (_selectedTime != null) {
      final DateTime now = DateTime.now();
      final DateTime scheduledDate = DateTime(now.year, now.month, now.day,
          _selectedTime!.hour, _selectedTime!.minute);
      NotificationService().scheduleAlarm(
        scheduledDate,
        'Alarm',
        'Time to wake up!',
      );
    }
  }

  void _cancelAlarm() {
    NotificationService().cancelAllNotifications();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Alarm'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _currentTime,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 40),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        _selectedTime != null
                            ? 'Alarm set for ${_selectedTime!.format(context)}'
                            : 'No alarm set',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FilledButton.icon(
                            onPressed: _selectTime,
                            icon: const Icon(Icons.alarm_add),
                            label: const Text('Select Time'),
                          ),
                          const SizedBox(width: 10),
                          FilledButton.icon(
                            onPressed: _setAlarm,
                            icon: const Icon(Icons.alarm_on),
                            label: const Text('Set Alarm'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      FilledButton.icon(
                        onPressed: _cancelAlarm,
                        icon: const Icon(Icons.alarm_off),
                        label: const Text('Cancel Alarm'),
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
