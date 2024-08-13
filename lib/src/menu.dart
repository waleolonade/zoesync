import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum _MenuOptions {
  navigationDelegate,
  userAgent,                                              // Add this line
}

class Menu extends StatefulWidget {                       // Convert to StatefulWidget
  const Menu({required this.controller, super.key});

  final WebViewController controller;

  @override                                               // Add from here
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {                    // To here.
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_MenuOptions>(
      onSelected: (value) async {
        switch (value) {
          case _MenuOptions.navigationDelegate:           // Modify from here
            await widget.controller
                .loadRequest(Uri.parse('https://zoesync.com.ng/'));
            break;
          case _MenuOptions.userAgent:
            final userAgent = await widget.controller
                .runJavaScriptReturningResult('navigator.userAgent');
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('$userAgent'),
            ));                                           // To here.
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.navigationDelegate,
          child: Text('Navigate to YouTube'),
        ),
        const PopupMenuItem<_MenuOptions>(                // Add from here
          value: _MenuOptions.userAgent,
          child: Text('Show user-agent'),
        ),                                                // To here.
      ],
    );
  }
}