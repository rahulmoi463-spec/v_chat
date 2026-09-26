import 'package:supabase_flutter/supabase_flutter.dart';


class SupabaseConfig {
  // আপনার Supabase ড্যাশবোর্ডের Settings > API থেকে পাওয়া URL ও Anon Key এখানে বসান
  static const String url = 'YOUR_SUPABASE_URL_HERE';
  static const String anonKey = 'YOUR_SUPABASE_ANON_KEY_HERE';

  static Future<void> init() async {
    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
    );
  }
}
