import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class NotificationService {



  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "instagram-clone-a6ff7",
      "private_key_id": "f96168de3e6ac35bf623a9fe9af53cec95545e92",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQD3ttrZAQh/1N0R\n4FBxvzP8dAnbm6pygiaRM+3cJ4H4Nfnk9f7VEVDB1NPZ8LIWUg1K9mzWKSadPnBM\nFKYkksSJLhdXaXUUDZkftgTrOJycX4NwRUIrxQZvr7YETsl6Tinlmg8nzPd2HkkN\nXvZA8sgWAMWjcQi8G03WjSMcnT+qek4Mxp0yDuMqRLhjqePGlmVg21EESrItADqr\nrhlI2aYPx0mABSF+rXjL+tc9gytAaBYmtZGMvv9zFhBqnzS/9goTdCiYrEs4vkts\nSqNFUQnaCrSWV2pKkXnIAGMl+vGvKZW2jfG/OH+ekdCOfGU2Mi5GTaZ2ZF98m2bG\nOTH/0LeVAgMBAAECggEAA94yaJ+1gZl8ojd9yhORkj2VnHzqb8NMgDPutjiqX4p9\njm+w56Qk6KyUFPEcjBtX4yBvQ/YnM4ldY4gRrWcv88cTzOTz/mN/9+4gVt6ZbhpS\nXmxrw2yI1Ib1MU1cTrFDF4y3nogld7iyrKdw8kQC5SUPRlAQ3Nm9oL4ExaucP43a\n0K3/NmpkAMUcn9rGBaoAp7TvR5pBlqiuVntv7qI3DB09cqYh+I5m5GeolFGnBKRu\nynKzjctzW4vX4HaT1RNHalIozN6zWbuCXPlb7AvTbyhqFCJpX990Ixs86b8RWEZp\njtr1Ucorc/Wm+cDtumrr4FBZ5Q4V3JfThoQaNfPYOQKBgQD/TCy/sKZdrbjkdq3Q\nTjQcnmnioDq5gYlSQnWJokoB18mVTVd9n6m0X/qXSFyP5TIyyHc6oly92+T27xI9\nl62Q44xfcVdRyhX9JNhzWzE+yGC2g2hzaANxDqdyFVXHEqLMQDYGcI4Vx9ny658P\nXi0JNgAEXUYOusx0XtHhekA+SwKBgQD4ZVauidioDVyde2UCLtRyBpcK28GfYgQV\ne59bmVlaQUIw+T7pvpEp8/OpiDBHZQVU43UKkz4ce9+w1n8Ml2k0k2jsQKPNy6tz\nWVxIPui4ekUeH9G8G+KWLRQ5sxbNDFOg88vIw7PxOlcRpuQizq9ZSfNbCJzV1zvS\nTCVBqj21nwKBgGEBSseTkcNqrSRyS90oufhd4RHxnB68r7cH9a1UcxZ8LeaDOslL\nD6qwBYHSRwmOJyLQtS0cYGzrzvZdJOsuZQ72x3HEmU9EoFJN28kJT47xiH4RNHEV\nhqlAzjM1FCDOXfmKNH0B65svEwuQqCGowSgM0rjV0Dbsl59oIAuy7hI9AoGBAIzz\nzHVsqXHrayO+MrpDYrB1xt4Vh9DuqMycAvjSkx6hK3No7GdtiShaU2lfa64HyDe8\nft0KYtN9A5lwjlXR0ZRRFdgCcjFEorzo93HTqPGOCIyol7Z7yF9Zo0F+u7CNjyMl\nVP1O+Fwps+DDaG/MAzrSuPJud7js0vhp1zZk6XGXAoGBAKm8IvEgsPX0aFNmtZwI\nFQXHeUgXlFD+Y2dN930ZM71AJA7HqpLtPU7VM9U+BZvCAWpfXvS8Zbp9D4A8IAxC\nh3+N78kxzNglTTyNot2UJ7QyM3N8CoNEfIgrqOUbKreYiCvQBNeu9gFKyPsuOu9A\nKaS6bAyh8lrNc4LLQo0IBnOE\n-----END PRIVATE KEY-----\n",
      "client_email":
          "notifications@instagram-clone-a6ff7.iam.gserviceaccount.com",
      "client_id": "109360859327612620727",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/notifications%40instagram-clone-a6ff7.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };
    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];
    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client);
    client.close();
    return credentials.accessToken.data;
  }

  static Future<void> sendNotification(
      String deviceToken, String title, String body) async {
    final String accessToken = await getAccessToken();
    String endpointFCM =
        'https://fcm.googleapis.com/v1/projects/instagram-clone-a6ff7/messages:send';
    final Map<String, dynamic> message = {
      "message": {
        "token": deviceToken,
        "notification": {"title": title, "body": body},
        "data": {
          "route": "home",
        }
      }
    };

    final http.Response response = await http.post(
      Uri.parse(endpointFCM),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      debugPrint('Notification sent successfully');
    } else {
      debugPrint('Failed to send notification');
    }
  }
}
