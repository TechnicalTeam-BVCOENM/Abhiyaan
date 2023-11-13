// For launching external urls
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {

   launchURL(Uri url) async {
  if (await canLaunchUrl(url)) {
    await launchUrl(url,
    mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

launchEmail(String email) async {
   Uri sendMail = Uri.parse("mailto:$email");
  if (await canLaunchUrl(sendMail)) {
    await launchUrl(sendMail, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $email';
  }
}

// get launchBrowserUrlHandler => _launchURL;
// get launchEmailHandler => _launchEmail;
}
