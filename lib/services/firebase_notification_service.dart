import 'dart:convert';

import 'package:fempinya3_flutter_app/firebase_options.dart';
import 'package:fempinya3_flutter_app/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroupHandler(RemoteMessage message) async {
  print('_firebaseMessagingBackgroupHandler: $message');
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  await FirebaseNotificationService.instance.setupFlutterNotifications();
  //await FirebaseNotificationService.instance.showNotification(message);
}

class FirebaseNotificationService {
  FirebaseNotificationService._();
  static final FirebaseNotificationService instance =
      FirebaseNotificationService._();

  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  bool _isFlutterLocalNotificationPluginInitialized = false;

  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroupHandler);
    
    await _requestPermission();

    await _setupMessageHandlers();

    // this token should be pushed to the API
    final token = await _messaging.getToken();
    print('FCM Token: $token');
  }

  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );

    print('Permission status: ${settings.authorizationStatus}');
  }

  Future<void> setupFlutterNotifications() async {
    if (_isFlutterLocalNotificationPluginInitialized) {
      return;
    }

    // android setup
    const channel = AndroidNotificationChannel(
      // TODO: Change this to your own channel id
      'fempinya_channel',
      'Fempinya Channel',
      description: 'Channel for Fempinya notifications',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // TODO: Change this for the fempinya icon
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // ios setup
    // final initializationSettingsDarwin = DarwinInitializationSettings(
    //   onDidReceiveLocalNotification: (id, title, body, payload) async {
    //     // Handle iOS foreground notification
    //   },
    // );

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsDarwin,
    );

    // flutter notification setup
    await _localNotifications.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) {
          print('onDidReceiveNotificationResponse: $details');
      // final payload = details.payload;
      // if (payload != null) {
      //   final data = Map<String, dynamic>.from(jsonDecode(payload));
      //   if (data.containsKey('action_url')) {
      //     _handleActionRouting(data['action_url'], data['resource_id']);
      //   }
      // }
    });

    _isFlutterLocalNotificationPluginInitialized = true;
  }

  Future<void> showNotification(RemoteMessage message) async {
    // message.data.notification is a json, where we can store more information than message.notification
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'fempinya_channel',
            'Fempinya Channel',
            channelDescription: 'Channel for Fempinya notifications',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data.toString(),
      );
    }
  }

  Future<void> _setupMessageHandlers() async {
    // Foreground message handler
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(message);
    });

    // Background message handler
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleBackgroundMessage(initialMessage);
    }
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    print('_handleBackgroundMessage: $message');
    // if (message.data.containsKey('action_url')) {
    //   _handleActionRouting(
    //       message.data['action_url'], message.data['resource_id']);
    // }
  }

  void _handleActionRouting(String pathName, String resourceId) {
    print('_handleActionRouting: Routing to path: $pathName with resource ID: $resourceId');
    if (resourceId != '') {
      GoRouter.of(MyApp.context)
          .pushNamed(pathName, pathParameters: {'eventID': resourceId});
    } else {
      GoRouter.of(MyApp.context).pushNamed(pathName);
    }
  }
}
