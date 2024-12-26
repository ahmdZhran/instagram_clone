import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class NotificationService {
  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "instagram-clone-a6ff7",
      "private_key_id": "26f44c880cce299cead0a0446706c7f83082a063",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDGtKXOiQmUCWuX\n5+ftBvZcaOF0JlerH+eg0DNcmT+BcEgf1d28sYBoFqdO4h0tBe9lABOWJNmN4fcf\n49pWGLyFZUpxnYmSbjytLqj1wmNXMPKW8sJZTqnBicnnolAWBtm4FrDj+jdaIUHB\nSwZSHt/F5bt3WiLj0Cb0T9xr9XDCAQXiYpbPp++tdluanPlv+Xl0hvztE3ZWrpU6\nkr8QhHQGFOnVTnMisKl18DqV5yFAAWk41bwEILg8lR3otAC5MjnIDCRJNFmJUHAR\njiZuLlrK/xS9VC5sOYkHARKGSjQyactTdKeFUgPOb0seIRAceyE86YEBsPtyIwb5\nRi6gop3xAgMBAAECggEAE1jqRoeBDV8T8PLhegqaIQIMxquHkHfPLLEs+RSKUor5\nWNEw8YMacLgY8wUw6E36QtwsrAs7PBV/A4XC3+xxaa8kvhaD20Q8x/OBu8khNU+E\npVYufnXacUfeZv1+vQBOgV5DO7Vkn5PapEyO6V7MdMdDNzIpcMNXEaV3fbMElz0I\nk/ddm1seTgacJnUVup8Gm8Uh0qTGszGpTtBXnKHZNYWqBAykvdPB5XIwkBkO9CQQ\n8+bU5WNHdD6vcMuVMnx/mXqxRMOY4Ntk9eE8/TbiVboOWm6e8aboWoxyfVTB2wE0\nsV38/kdZi/TOWNGiuUvL3IUGz6gYNnoSsryJ4Jou6QKBgQDm095B0OgwaWd7gwv3\nyz0UJyxJcR02DxR30aZnn2vnwjMpgLOnHzjPcJYZ26LNY7Bz24UNDa6gpPSy9hP8\ncxIm74dtxrmwZZyd7MCWiF8eaC3vYh71p70Kzg+xQnmB9/vnedlXMvTAPfsQCEea\nkIjR41bt5kW3QtElER2wf8jyKQKBgQDcYAO4Q5aIvompEnT7N1+JpHtMbJuQnOEJ\n+oGuEsOnZTXQDF2BKLFoTrHmvr7JY6ZKl5c1pB7xeVJZoKCWs/ivG4Y7hMlMAvrh\n/AjoSQb2mIJ7EITGvYWN9zJrlEXLSWLLXrJsKHyxj7pPc05G6CcUTFAcQl9mzdiQ\nCbzcVy2WiQKBgQDKkPnGVne9LHL08D8LeV8jlXEHDm4tJ7S1pdVbsIr4evN9I4YF\nTqADY3FGRfosNqT+N5Ier3glYD2h49QMQkuWwbPewXvpcnKsIL2uHQUkYRaWskwr\nFsYOemFJFOYfCaoWLFdwb7ZcEsiF/E4iNV7smo6J/gAGYGu8FLYyUyHcaQKBgDsv\najBVrpshGRWYSGSjtXvg+eBHluwaxfGJHsTiczuE2hP7Di2/AQ5zfCHtfo3VvnZw\nCgM1Bb5yh+RcWGTBBvv4V2+qtOk+L6T7rGS+ICmgQgLNJ+u8QJ8lEZyE4M288tSN\npTuZEAwb/ryRyicO+FfiOu2sAbU5eX0NsHQ40ZyJAoGBAMXsNwrXo3BeNzJjTfkW\nwt7jo9gSU51dY36+IN0+U6bHIZjZCtFgYw0pYqpsTzKkZJ1UcxVmhfsP1s5nBj+D\nM/jklOS39xY3Mc+PA3HB6dIGnW4gO1jtIwjYyPvRIh4/pAYKXjCbLgcf9eGLIsca\neObo23/5BXhMHymizWqgI8Ul\n-----END PRIVATE KEY-----\n",
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
