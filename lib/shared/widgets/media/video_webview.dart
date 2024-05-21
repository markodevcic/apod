import 'package:apod/utilities/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoWebView extends StatefulWidget {
  final String? url;

  const VideoWebView({super.key, required this.url});

  @override
  VideoWebViewState createState() => VideoWebViewState();
}

class VideoWebViewState extends State<VideoWebView> {
  late WebViewController _webViewController;

  @override
  void initState() {
    late Uri url;
    Uri uri = Uri.parse(widget.url!);
    if (uri.scheme != 'http' && uri.scheme != 'https') {
      url = Uri.parse('https://${uri.host}${uri.path}');
    } else {
      url = Uri.parse(widget.url!);
    }
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColor.cosmicBlue)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            LinearProgressIndicator(value: progress / 100);
          },
          onPageStarted: (url) {},
          onPageFinished: (url) {},
          onWebResourceError: (error) {
            Text('Error: ${error.description}');
          },
          onNavigationRequest: (request) async {
            if (!request.url.contains('/embed/')) {
              await launchUrl(Uri.parse(request.url),
                  mode: LaunchMode.externalApplication);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(url);
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: _webViewController,
    );
  }
}
