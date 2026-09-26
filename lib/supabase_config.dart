import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String url = 'https://hctaktpmvyneoaoppout.supabase.co/rest/v1/';
  static const String anonKey = 'Sb_publishable_vetjtgjPS6CEP-35H1NGmA_iRqXf4sz';

  static Future<void> init() async {
    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
    );
  }
}
