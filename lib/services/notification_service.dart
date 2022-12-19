import 'dart:async';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/subjects.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../themes/themes.dart';

class NotificationService {
  final _localNotifications = FlutterLocalNotificationsPlugin();
  final behaviorSubject = BehaviorSubject<ReceivedNotification>();
  final selectNotificationStream = StreamController<String?>.broadcast();
  final String navigationActionId = 'navigationActionId';

  /*--------------------------------------------------------------------------*/
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  NotificationService._internal() {
    if (Platform.isIOS) {
      _requestIOSPermission();
    }

    initializePlatformNotifications();
  }
  /*--------------------------------------------------------------------------*/

  void _requestIOSPermission() {
    _localNotifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()!
        .requestPermissions(alert: false, badge: true, sound: true);
  }

  Future<void> initializePlatformNotifications() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(
      tz.getLocation(await FlutterNativeTimezone.getLocalTimezone()),
    );

    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final initializationSettingsIOS = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        behaviorSubject.add(ReceivedNotification(
          id: id,
          title: title,
          body: body,
          payload: payload,
        ));
      },
    );

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationStream.add(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            if (notificationResponse.actionId == navigationActionId) {
              selectNotificationStream.add(notificationResponse.payload);
            }
            break;
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    // final details = await _localNotifications.getNotificationAppLaunchDetails();
    // if (details != null && details.didNotificationLaunchApp) {}
  }

  static void notificationTapBackground(
    NotificationResponse notificationResponse,
  ) {
    print(
      'notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}',
    );
  }
  /*-------------------------- DISPLAY NOTIFICATIONS -------------------------*/

  Future<NotificationDetails> _notificationDetails() async {
    /*--------------------------- CONFIG ANDROID -----------------------------*/
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel id',
      'channel name',
      channelDescription: 'channel description',
      groupKey: 'com.example.firebase_app_bloc',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      ticker: 'ticker',
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
      styleInformation: BigPictureStyleInformation(
        DrawableResourceAndroidBitmap('big_picture'),
      ),
      icon: 'app_icon',
      color: DarkTheme.primaryBlue500,
    );

    /*----------------------------- CONFIG IOS -------------------------------*/
    const iosNotificationDetails = DarwinNotificationDetails(
      threadIdentifier: "thread1",
      attachments: <DarwinNotificationAttachment>[
        DarwinNotificationAttachment('big_picture')
      ],
    );

    /*------------------------------------------------------------------------*/

    final details = await _localNotifications.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      selectNotificationStream.add(details.notificationResponse!.payload);
    }

    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosNotificationDetails,
    );

    return platformChannelSpecifics;
  }

  Future<void> showLocalNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    final platformChannelSpecifics = await _notificationDetails();
    await _localNotifications.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  /*--------------------- DISPLAY SCHEDULED NOTIFICATIONS --------------------*/

  Future<void> showPeriodicLocalNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    final platformChannelSpecifics = await _notificationDetails();
    await _localNotifications.periodicallyShow(
      id,
      title,
      body,
      RepeatInterval.everyMinute,
      platformChannelSpecifics,
      payload: payload,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> showScheduledLocalNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
    required int seconds,
  }) async {
    final platformChannelSpecifics = await _notificationDetails();
    await _localNotifications.zonedSchedule(
      id,
      title,
      body,
      //tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
      _nextInstanceOfTime(),
      platformChannelSpecifics,
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  _nextInstanceOfTime() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 7);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  /*----------------------- DISPLAY GROUPED NOTIFICATIONS --------------------*/
  Future<NotificationDetails> _groupedNotificationDetails() async {
    const List<String> lines = <String>[
      'group 1 First drink',
      'group 1   Second drink',
      'group 1   Third drink',
      'group 2 First drink',
      'group 2   Second drink'
    ];
    const InboxStyleInformation inboxStyleInformation = InboxStyleInformation(
      lines,
      contentTitle: '5 messages',
      summaryText: 'missed drinks',
    );

    /*--------------------------- CONFIG ANDROID -----------------------------*/
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel id 1',
      'channel name 1',
      channelDescription: 'channel description 1',
      groupKey: 'com.example.firebase_app_bloc 1',
      setAsGroupSummary: true,
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      ticker: 'ticker',
      styleInformation: inboxStyleInformation,
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
      icon: 'app_icon',
      color: DarkTheme.primaryBlue500,
    );

    /*----------------------------- CONFIG IOS -------------------------------*/
    const iosNotificationDetails = DarwinNotificationDetails(
      threadIdentifier: "thread2",
    );

    /*------------------------------------------------------------------------*/

    final details = await _localNotifications.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      selectNotificationStream.add(details.notificationResponse!.payload);
    }

    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosNotificationDetails,
    );

    return platformChannelSpecifics;
  }

  Future<void> showGroupedNotifications() async {
    final platformChannelSpecifics = await _notificationDetails();
    final groupedPlatformChannelSpecifics = await _groupedNotificationDetails();
    await _localNotifications.show(
      0,
      "group 1",
      "First drink",
      platformChannelSpecifics,
    );
    await _localNotifications.show(
      1,
      "group 1",
      "Second drink",
      platformChannelSpecifics,
    );
    await _localNotifications.show(
      3,
      "group 1",
      "Third drink",
      platformChannelSpecifics,
    );
    await _localNotifications.show(
      4,
      "group 2",
      "First drink",
      Platform.isIOS
          ? groupedPlatformChannelSpecifics
          : platformChannelSpecifics,
    );
    await _localNotifications.show(
      5,
      "group 2",
      "Second drink",
      Platform.isIOS
          ? groupedPlatformChannelSpecifics
          : platformChannelSpecifics,
    );
    await _localNotifications.show(
      6,
      Platform.isIOS ? "group 2" : "Attention",
      Platform.isIOS ? "Third drink" : "5 missed drinks",
      groupedPlatformChannelSpecifics,
    );
  }

  void cancelSingleNotifications() => _localNotifications.cancel(0);
  void cancelAllNotifications() => _localNotifications.cancelAll();
}

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}
