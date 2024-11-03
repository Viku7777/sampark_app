import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:googleapis_auth/auth_io.dart';

class NoificationRepository {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static FirebaseMessaging fcm = FirebaseMessaging.instance;
  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'Chat Notifications',
    'Sampark Chats',
    description: 'This channel is used for Chats notifications.',
    importance: Importance.high,
    playSound: true,
  );
// Creating notification channel
  static Future<void> notificationPlugin() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
// // requesting permission for sending notification
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.requestNotificationsPermission();

// Android Initialization
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    // Initializing flutter local notification
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        if (details.id != null) {
          print("set 1");
          print(details.input);
          print(details.id);
          print(details.actionId);
          print(details.notificationResponseType);
          print(details.payload);
        }
      },
    );
    await fcm.requestPermission(
        alert: true, announcement: true, badge: true, sound: true);
    FirebaseMessaging.onMessage.listen((RemoteMessage e) {
      showNotification(e.notification!.title.toString(),
          e.notification!.body.toString(), e.data);
    });

    var token = await fcm.getToken();
    print("fcm token is $token");
  }

  static void sendNotification(
      String title, String bodydata, Map data, String token) async {
    String url =
        "https://fcm.googleapis.com/v1/projects/sampark-f6b6c/messages:send";
    var serverToken = await GetServiceKey().getServiceKeyToken();

    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $serverToken",
    };
    var body = {
      "message": {
        "token": token,
        "notification": {"body": bodydata, "title": title},
        "data": data
      }
    };

    http.Response response = await http.post(
      Uri.parse(url),
      headers: header,
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      debugPrint("notification send sucessfully");
    } else {
      debugPrint("something went wrong");
    }
  }

  static void showNotification(
      String title, String message, Map payload) async {
    flutterLocalNotificationsPlugin.show(
        0,
        title,
        message,
        NotificationDetails(
            android: AndroidNotificationDetails(
                NoificationRepository.channel.id,
                NoificationRepository.channel.name,
                channelDescription: NoificationRepository.channel.description,
                importance: Importance.high,
                color: Colors.blue,
                actions: [
                  const AndroidNotificationAction("112", "Send",
                      allowGeneratedReplies: true,
                      showsUserInterface: true,
                      titleColor: Colors.black,
                      inputs: [
                        AndroidNotificationActionInput(
                          label: "Type a message",
                        )
                      ])
                ],
                category: AndroidNotificationCategory.message,
                playSound: true,
                icon: 'ic_launcher'),
            iOS: const DarwinNotificationDetails(
                presentSound: true, presentAlert: true, presentBadge: true)),
        payload: jsonEncode({"name": "Vikrant", "ChatroomID": "gdsxgdshsd"}));
  }
}

class GetServiceKey {
  Future<String> getServiceKeyToken() async {
    final scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging",
    ];
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "sampark-f6b6c",
          "private_key_id": "9fff4ed1ff4728728ae230bb63bde3def0be1681",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCwWAzm1EwX5ZEy\nLiL7b2VxykK7fv3RVnxLQBS9APheeH1Nj1pDrpkLEG63bW8hwMyxTrrZqzwefIcC\nQOGAGurEHNnyqh9mUomm7JmMIHFWf2HJaZmnp4cdYYXG5SRruyno2tw//CNulLve\nlvt6CwrMhdj6qK/Ak0KPZRJSmaa0mg3o5Ynb5Fu2Q4sLSgOKQr5lsXt5T4lYfE71\nqIvBh6w3kHk3neYJ74FazLSnw8710K1S3VeBNEZnjOHUBnJhpzICXG/zsPV+JmYq\nnVQvXZlYLnuFvoRf4t9gxf9P7lVzE1DXhBIlqOe5wAf8HXGbRgMxZYaB8Fra9W3Z\nvs6Fy/33AgMBAAECggEAORtypigXMl/yOu1s/78N+6E0JjMUcIARBW+Np72SMUnU\nzlK/uQ5oWohqSnWimSwuPbdQ1F/bOsY6FJU9Ubal03fCbw7/1yugj1Gs0g/JlGjx\nGoBbtcsPewjTgVtAhbDZfCKwU/pL4SpCgu2jJ90+lIg+AcKyE+u8kOJ64gwHTBHS\niqDz4dLkQXokaREOJO0RwULWBejlYRjHDfdUiSe5LKWeDQNl08BZ4ji1VjDKuzm4\nq+HXwn8E5qg0OBpl9nPs2a75HE7uFEMNniWkTw3z0ulqeCBrnXyNt4P1tAJiNcBU\nNo6Xw9ntMQpa4CTB/BnpdL5siPvj1tl7gwUB6Gvk9QKBgQD2uHRAfjC3q248aWjr\ninB+PWgvzAd6mmBiQ8wLMkdkhO08yoACnGaNDMYKyTVfblTyd8DoJgmoyndv9F6n\nkL5C6ie3fefdxX5z4lGJrniflJqMu1ehHn+JHtHwjMq7O54pHenwV2vPb5CG4sXT\n7VwyT4wyzQxV7sb+R9SjbxluswKBgQC2+fnm3RL/LE6J5Z7VhnlWtBdLdnv8y1bd\nPYL+zsdwHpV6EWpNwOTdq1yIbzcyjI/hgfW88QXMH3lL39Q0QK9JGDhajaG9zVQx\n1c/APgfzf9WO3cNN+2VJ3ngTIQ21AUMcJZKBQn2prLhl6TmUatfhAFfnPswvyElm\n/mnAAhqVrQKBgQDbT3uHGKUVnz2OVeT9+0Gj9dH3KtY7FZ83uixWh4sOv1pi/15q\n87v1BbXFQLZA7kJ0hh7kPWu4rsEcs4ywRunZcWt8oF7LtBKD0FnKmVx//gijsKRk\nhEe6C7tyqLRNWuFsizq4ef1Ll1BRlqNjj0q1LiDhx4N/n5Ej15Yc8VUaIQKBgA1j\n5cHbU9SQrX6x6xm9KYwKydmf5hrt1oGCSt/Syg2Ob2nrdFgUUatXKwJhAS0V1EGw\nfQdCrCXv97RxwNnCEhHLT/RwgPGe4RZ0iyuKXpKXPE2kNPKz/wmU2jysIpCocvzQ\nUxRahU+xcB0lIC2YVAwHNmeZ1N96TMTYwWxnuwJRAoGBAOt6S997L6Y5dN87sGDK\nGNWFLHbnwcwoUoejgRn0sH6MLi2rqiZ6puqHR77cirztpq4S/mezZLV9zoLTCQN4\nmc6nYWslfwGT0z/fmusinFvgGRa2HvSqIS6fD4R9WyshIgmdZk+4jWeXUYcfUIuz\npm67F6boIRLUkQ4nXWoFycyT\n-----END PRIVATE KEY-----\n",
          "client_email":
              "firebase-adminsdk-oog0t@sampark-f6b6c.iam.gserviceaccount.com",
          "client_id": "110915122578920706034",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-oog0t%40sampark-f6b6c.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        scopes);
    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}


// cvvFgbRQRruyTevrUQ-VyM:APA91bFz3uNPFPWI_MkreV7EfV8ii6OOkpbVL9FcEdW8-znEajMth68Pk1arbHrL-xsd2skumA15MAvDQLsxZd4PFJI9xuLQpFcZGuIPgayLvO8sVgw0ZXA