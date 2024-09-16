import 'package:url_launcher/url_launcher.dart';

const String facebook =
    'https://www.facebook.com/profile.php?id=61564503605463&mibextid=kFxxJD';
const String call = "tel://01126732555";
const String whatsapp = '+20 112 673 2555';
Future<void> launchFacebookProfile() async {
  const facebookProfileUrl = facebook;
  if (await canLaunchUrl(Uri.parse(facebookProfileUrl))) {
    await launchUrl(Uri.parse(facebookProfileUrl));
  } else {
    throw 'Could not launch $facebookProfileUrl';
  }
}
