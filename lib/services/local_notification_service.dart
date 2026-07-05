import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  LocalNotificationService._();

  static final LocalNotificationService instance = LocalNotificationService._();

  static const _dailyPlayReminderId = 800;
  static const _dailyPlayReminderTitle = 'Ready for today\'s puzzle?';
  static const _dailyPlayReminderBody =
      'Take a small break and keep your Zigloom streak going.';
  static const _dailyPlayReminderPayload = 'daily_play_reminder';

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  var _isInitialized = false;

  Future<void> initializeAndScheduleDailyPlayReminder() async {
    if (kIsWeb || defaultTargetPlatform == TargetPlatform.linux) {
      return;
    }

    await _initialize();
    await _requestPermissions();
    await _scheduleDailyPlayReminder();
  }

  Future<void> _initialize() async {
    if (_isInitialized) return;

    await _configureLocalTimezone();

    const androidSettings = AndroidInitializationSettings('launcher_icon');
    const darwinSettings = DarwinInitializationSettings();
    const linuxSettings = LinuxInitializationSettings(
      defaultActionName: 'Open notification',
    );
    const windowsSettings = WindowsInitializationSettings(
      appName: 'Zigloom',
      appUserModelId: 'spoon.app.zigloom',
      guid: '9e17d996-7bf5-4f1b-8d7f-105a93c31a77',
    );
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
      macOS: darwinSettings,
      linux: linuxSettings,
      windows: windowsSettings,
    );

    await _notifications.initialize(settings: settings);
    _isInitialized = true;
  }

  Future<void> _configureLocalTimezone() async {
    tz_data.initializeTimeZones();

    try {
      final timezone = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timezone.identifier));
    } on Object {
      tz.setLocalLocation(tz.UTC);
    }
  }

  Future<void> _requestPermissions() async {
    await _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    await _notifications
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    await _notifications
        .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<void> _scheduleDailyPlayReminder() async {
    const androidDetails = AndroidNotificationDetails(
      'daily_play_reminder',
      'Daily play reminder',
      channelDescription: 'Daily reminder to play Zigloom',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    const darwinDetails = DarwinNotificationDetails();
    const details = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
      macOS: darwinDetails,
    );

    await _notifications.zonedSchedule(
      id: _dailyPlayReminderId,
      title: _dailyPlayReminderTitle,
      body: _dailyPlayReminderBody,
      scheduledDate: _nextEightPm(),
      notificationDetails: details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: _dailyPlayReminderPayload,
    );
  }

  tz.TZDateTime _nextEightPm() {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      20,
    );

    if (!scheduledDate.isAfter(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }
}
