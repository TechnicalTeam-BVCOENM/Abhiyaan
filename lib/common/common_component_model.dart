// For launching external urls
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {

   _launchURL(Uri url) async {
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchEmail(String email) async {
   Uri sendMail = Uri.parse("mailto:$email");
  if (await canLaunchUrl(sendMail)) {
    await launchUrl(sendMail);
  } else {
    throw 'Could not launch $email';
  }
}

get launchBrowserUrlHandler => _launchURL;
get launchEmailHandler => _launchEmail;
}
