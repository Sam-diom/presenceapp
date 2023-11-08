import 'package:flutter/material.dart';

class PresenceScreen extends StatefulWidget {
  static const String id = 'presence';
  const PresenceScreen({super.key});

  @override
  State<PresenceScreen> createState() => _PresenceScreenState();
}

class _PresenceScreenState extends State<PresenceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text('nothing for moment')),
      ),
    );
  }
}