import 'package:supabase/supabase.dart';

class DatabaseApi {
  late SupabaseClient _supabaseClient;
  final String _supabaseUrl = "https://zhfwmhksjrmpaegmvdiz.supabase.co";
  final String _supabaseKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpoZndtaGtzanJtcGFlZ212ZGl6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NDg0NjExNjgsImV4cCI6MTk2NDAzNzE2OH0.yn_DAar7LaWoiCcOXuQG33CP2GGYSgP63Ea51B2bF0Y";

  DatabaseApi() {
    _supabaseClient = SupabaseClient(_supabaseUrl, _supabaseKey);
  }

  SupabaseClient getSupabaseClient() {
    return _supabaseClient;
  }
}
