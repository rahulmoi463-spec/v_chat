import 'package:flutter/material.dart';
import 'gb_settings_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('V-Chat (GB)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GBSettingsScreen()),
              );
            },
          )
        ],
      ),
      body: const Center(
        child: Text(
          'আপনার চ্যাট লিস্ট এখানে দেখাবে',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
