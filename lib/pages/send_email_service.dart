import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class SendEmailService {
  static sendEmail(
      {required String name,
      required String email,
      required String subject,
      required String message}) async {
    try {
      final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(
            {
              'service_id': 'service_jhhzeg3',
              'template_id': 'template_o9pzlzv',
              'user_id': 'I2jVWs123RAkl0RCh',
              'template_params': {
                'user_name': name,
                'user_email': email,
                'user_subject': subject,
                'user_message': message
              }
            },
          ));
      if (response.statusCode == 200) {}
      debugPrint("Email sent successfully");
    } catch (e) {
      debugPrint("Error sending Email $e");
    }
  }
}
