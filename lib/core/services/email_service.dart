import 'package:dio/dio.dart';

/// EmailJS Service for sending contact form emails
///
/// SETUP INSTRUCTIONS:
/// 1. Go to https://www.emailjs.com/ and create a free account
/// 2. In EmailJS Dashboard:
///    - Click "Email Services" → "Add New Service" → Choose your email provider (Gmail recommended)
///    - Copy the SERVICE ID (looks like: service_xxxxxxx)
/// 3. Click "Email Templates" → "Create New Template"
///    - Use these variable names in your template:
///      {{from_name}} - Sender's name
///      {{from_email}} - Sender's email
///      {{message}} - Message content
///      {{to_name}} - Your name (recipient)
///      {{reply_to}} - Reply-to email
///    - Copy the TEMPLATE ID (looks like: template_xxxxxxx)
/// 4. Go to "Account" → "General" → Copy your PUBLIC KEY
/// 5. Replace the values below with your actual credentials
class EmailService {
  // Replace these with your EmailJS credentials from https://www.emailjs.com/
  static const String _serviceId = 'service_z4f4aow';
  static const String _templateId = 'template_umqdwov';
  static const String _publicKey = 'rfnHNHQ1wpQubh52x';

  /// Send contact form email
  ///
  /// Returns true if email was sent successfully, false otherwise
  static Future<bool> sendContactEmail({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      final data = {
        'service_id': _serviceId,
        'template_id': _templateId,
        'user_id': _publicKey,
        'template_params': {'name': name, 'email': email, 'message': message},
      };

      print('📧 Attempting to send email via REST API...');
      print('Service: $_serviceId');
      print('Template: $_templateId');
      print('User ID: $_publicKey');

      final dio = Dio();
      final response = await dio.post(
        'https://api.emailjs.com/api/v1.0/email/send',
        data: data,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      print('✅ Email sent successfully! Response: ${response.data}');
      return true;
    } on DioException catch (e) {
      print('❌ EmailJS API Error: ${e.response?.statusCode}');
      print('❌ Message: ${e.response?.statusMessage}');
      print('❌ Response Data: ${e.response?.data}');
      return false;
    } catch (e) {
      print('❌ Unexpected error sending email: $e');
      return false;
    }
  }
}
