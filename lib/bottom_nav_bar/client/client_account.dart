import 'package:flutter/material.dart';

class ClientAccount extends StatefulWidget {
  const ClientAccount({super.key});

  @override
  State<ClientAccount> createState() => _ClientAccountState();
}

class _ClientAccountState extends State<ClientAccount> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('Client Account'),
        ),
      ),
    );
  }
}
