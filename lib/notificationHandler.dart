import 'dart:async';
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

Future<Map<String, dynamic>?> sendAndRetrieveMessage({
  // required String token,
  required String message,
  required BuildContext context,
  String? imageUrl,
  required String title,
}) async {
  final String serverToken =
      "AAAACwTfCj4:APA91bEOcuQEIZtyywS3Ur5vVRmr3NKYijTE69EaHOaRGk8-rDK_hyoRVDCvAjdbueAmxPsUfjqylwZohqYpbKZseZboE5iRsXABDBGyxhtlGfBDhsXHw0JhHTMNS9Q5D5f7ZkpHpdN-";
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FirebaseMessaging.instance.subscribeToTopic("kanessa_channel");
  await http
      .post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverToken',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': message,
              'title': '$title',
              imageUrl == null ? "" : "image": imageUrl
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            'to': "/topics/kanessa_channel",
          },
        ),
      )
      .then((value) => print("Notification Sent"));

  // await http
  //     .post(
  //       Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $serverToken',
  //       },
  //       body: jsonEncode(
  //         <String, dynamic>{
  //           "message": {
  //             "topic": "kanessa_channel",
  //             "notification": {
  //               "title": "Breaking News",
  //               "body": "New news story available."
  //             },
  //             "data": {"story_id": "story_12345"}
  //           }
  //         },
  //       ),
  //     )
  //     .then((value) => print("Notification Sent"));
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
          ));
    }
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(notification.title!),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notification.body!),
                  ],
                ),
              ),
            );
          });
    }
  });
  return null;
}
