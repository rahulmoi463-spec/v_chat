import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class GBSettingsScreen extends StatelessWidget {
  const GBSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AppSettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('GB Settings & Theme')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark Mode / ডার্ক মোড'),
            value: settings.themeMode == ThemeMode.dark,
            onChanged: (val) => settings.toggleTheme(val),
          ),
          const Divider(),
          ListTile(
            title: const Text('App Language / অ্যাপের ভাষা'),
            subtitle: Text(settings.locale.languageCode == 'bn' ? 'বাংলা' : 'English'),
            trailing: PopupMenuButton<String>(
              onSelected: (lang) {
                settings.setLanguage(Locale(lang));
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'bn', child: Text('বাংলা')),
                const PopupMenuItem(value: 'en', child: Text('English')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
