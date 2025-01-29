// ignore: depend_on_referenced_packages
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Future<void> logTaskCreated() async {
    await _analytics.logEvent(name: 'task_created');
  }

  Future<void> logTaskCompleted() async {
    await _analytics.logEvent(name: 'task_completed');
  }
}
