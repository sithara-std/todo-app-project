// ignore: depend_on_referenced_packages
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class CloudMessagingService {
  static final CloudMessagingService _instance = CloudMessagingService._internal();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  factory CloudMessagingService() {
    return _instance;
  }

  CloudMessagingService._internal();

  // Initialize Firebase Messaging
  Future<void> initialize() async {
    // Request notification permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handle permission status
    _handlePermissionStatus(settings);

    // Configure message handlers
    _setupMessageHandlers();
  }

  // Handle Permission Status
  void _handlePermissionStatus(NotificationSettings settings) {
    switch (settings.authorizationStatus) {
      case AuthorizationStatus.authorized:
        debugPrint('User granted notification permissions');
        break;
      case AuthorizationStatus.provisional:
        debugPrint('User granted provisional permissions');
        break;
      default:
        debugPrint('User declined notification permissions');
    }
  }

  // Setup Message Handlers
  void _setupMessageHandlers() {
    // Foreground message handler
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleForegroundMessage(message);
    });

    // Background message handler
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleBackgroundMessage(message);
    });
  }

  // Handle Foreground Messages
  void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('Received foreground message');
    debugPrint('Title: ${message.notification?.title}');
    debugPrint('Body: ${message.notification?.body}');
  }

  // Handle Background Messages
  void _handleBackgroundMessage(RemoteMessage message) {
    debugPrint('Message opened app');
    debugPrint('Title: ${message.notification?.title}');
  }

  // Get FCM Token
  Future<String?> getToken() async {
    try {
      return await _messaging.getToken();
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
      return null;
    }
  }

  // Subscribe to Topic
  Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
    debugPrint('Subscribed to $topic');
  }

  // Unsubscribe from Topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
    debugPrint('Unsubscribed from $topic');
  }
}
