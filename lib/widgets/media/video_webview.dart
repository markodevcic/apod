import 'package:flutter/material.dart';
import 'package:apod/constants/app_color.dart';
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
      ..loadRequest(Uri.parse(widget.url!));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: _webViewController,
    );
  }
}
