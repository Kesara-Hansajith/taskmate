import 'package:flutter/material.dart';

class ClientMessaging extends StatefulWidget {
  const ClientMessaging({super.key});

  @override
  State<ClientMessaging> createState() => _ClientMessagingState();
}

class _ClientMessagingState extends State<ClientMessaging> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('Client Messaging'),
        ),
      ),
    );
  }
}
