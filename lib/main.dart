import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'supabase_config.dart';
import 'screens/chat_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.init();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppSettingsProvider(),
      child: const VChatApp(),
    ),
  );
}

class AppSettingsProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  Locale _locale = const Locale('bn');

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setLanguage(Locale newLocale) {
    _locale = newLocale;
    notifyListeners();
  }
}

class VChatApp extends StatelessWidget {
  const VChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AppSettingsProvider>(context);

    return MaterialApp(
      title: 'V-Chat',
      debugShowCheckedModeBanner: false,
      themeMode: settings.themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.teal,
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF075E54)),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121B22),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1F2C34)),
      ),
      locale: settings.locale,
      supportedLocales: const [Locale('bn'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const ChatListScreen(),
    );
  }
}
