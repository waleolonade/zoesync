import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'src/menu.dart';                               // ADD
import 'src/navigation_controls.dart';
import 'src/web_view_stack.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const WebViewApp(),
    ),
  );
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://zoesync.com.ng/'),
      );
  }


  // Define navigationDelegate to handle navigation requests
  NavigationDelegate get navigationDelegate => NavigationDelegate(
    onNavigationRequest: (navigation) {
      final host = Uri.parse(navigation.url).host;
      if (host.contains('https://zoesync.com.ng/')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Blocking navigation to $host'),
          ),
        );
        return NavigationDecision.prevent;
      }
      return NavigationDecision.navigate;
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('zoesync'),
        actions: [
          NavigationControls(controller: controller),
        ],
      ),
      body: WebViewStack(
        controller: controller,
        navigationDelegate: navigationDelegate,
      ),
    );
  }
}