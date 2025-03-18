import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroupHandler(RemoteMessage message) async {
  await NotificationService.instance.setupFlutterNotifications();
  await NotificationService.instance.showNotification(message);
}

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

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
      // TODO: here we would configure what happens when the user taps on the notification
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
    if (message.data['type'] == 'chat') {
      // open chat scrreen
      // TODO: configure for correct type
    }
  }
}
