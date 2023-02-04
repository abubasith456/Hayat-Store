import 'package:url_launcher/url_launcher.dart';

launchURL({required String? url, required String optionalUrl}) async {
  if (await canLaunchUrl(Uri.parse(url!))) {
    await launchUrl(Uri.parse(url));
  } else {
    print('Could not launch $url');
    //try to open optional update link
    if (await canLaunchUrl(Uri.parse(optionalUrl))) {
      await launchUrl(Uri.parse(optionalUrl));
    } else {
      throw "'Could not launch $optionalUrl'";
    }
  }
}
