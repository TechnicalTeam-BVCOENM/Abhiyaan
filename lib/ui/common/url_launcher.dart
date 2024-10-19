import 'package:abhiyaan/file_exporter.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (!await launchUrl(launchUri)) {
      throw 'Could not launch $launchUri';
    }
  }

  launchEmail(String email) async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    try {
      Uri sendMail = Uri(
        scheme: 'mailto',
        path: email,
        query: encodeQueryParameters(<String, String>{
          'subject': 'Regarding help in Abhiyaan App',
          'body': 'Hey, how can we help you?',
        }),
      );
      if (await canLaunchUrl(sendMail)) {
        await launchUrl(sendMail, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $email';
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

// get launchBrowserUrlHandler => _launchURL;
// get launchEmailHandler => _launchEmail;
}
