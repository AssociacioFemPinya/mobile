import 'dart:convert';

import 'package:fempinya3_flutter_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroupHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}

class FirebaseNotificationService {
  FirebaseNotificationService._();
  static final FirebaseNotificationService instance =
      FirebaseNotificationService._();

  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  bool _isFlutterLocalNotificationPluginInitialized = false;

  Future<void> initialize() async {
    // Set up background message handler first
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroupHandler);
    
    // Initialize the Flutter Local Notifications Plugin
    await setupFlutterNotifications();
    
    // Request permissions
    await _requestPermission();

    // Set up message handlers
    await _setupMessageHandlers();

    // TODO: this token should be pushed to the API
    final token = await _messaging.getToken();
    print('FCM Token: $token');
  }

  Future<void> _requestPermission() async {
    // Request Firebase Messaging permissions
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );
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
      playSound: true,
      enableVibration: true,
      showBadge: true,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // TODO: Change this for the fempinya icon
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // ios setup
    final initializationSettingsDarwin = DarwinInitializationSettings(
      // Removed onDidReceiveLocalNotification as it is no longer supported
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
        final String? payload = notificationResponse.payload;
        
        if (payload != null) {
          try {
            final data = Map<String, dynamic>.from(jsonDecode(payload));
            
            // Create a RemoteMessage-like object to reuse the same handler
            final message = RemoteMessage(data: data);
            _handleBackgroundMessage(message);
            
            // If you need specific routing
            if (data.containsKey('action_url')) {
              _handleActionRouting(data['action_url'], data['resource_id'] ?? '');
            }
          } catch (e) {
            print('Error processing notification payload: $e');
          }
        } else {
          print('WARNING: Notification payload is null');
        }
    }

    // flutter notification setup
    await _localNotifications.initialize(initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );

    _isFlutterLocalNotificationPluginInitialized = true;
  }

  Future<void> showNotification(RemoteMessage message) async {    
    // message.data.notification is a json, where we can store more information than message.notification
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      final encodedPayload = jsonEncode(message.data);
      
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
            playSound: true,
            enableVibration: true,
            autoCancel: true,  // Auto dismiss when tapped
            ongoing: false,    // Not persistent
            channelShowBadge: true,
            fullScreenIntent: true,  // Important for user interaction
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            interruptionLevel: InterruptionLevel.active,  // Important for user interaction
          ),
        ),
        payload: encodedPayload,
      );
    } else {
      print('WARNING: Cannot show notification - notification or android is null');
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
    if (message.data.containsKey('action_url')) {
      _handleActionRouting(
          message.data['action_url'], message.data['resource_id']);
    }
  }

  void _handleActionRouting(String pathName, String resourceId) {
  }
}