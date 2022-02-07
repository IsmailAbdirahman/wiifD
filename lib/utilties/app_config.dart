import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase/supabase.dart';

//Supabase init
String supabaseUrl = "https://cboidvnsbqigdgslvmcf.supabase.co";
String supabaseKey =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTY0MTA1OTgwNywiZXhwIjoxOTU2NjM1ODA3fQ.rrjR_zlNHWEQANMDQxf7s10iiC2QNfzAcDfDdbNVqU0";
SupabaseClient client = SupabaseClient(supabaseUrl, supabaseKey);

// Google sign in and userUID
const String clientId =
    '928487410803-3esluc2plbtqav6aaa7c7bm7e92gd5go.apps.googleusercontent.com';
String userUID = FirebaseAuth.instance.currentUser!.uid;

//RevenueCat API
const paymentAPIkey = 'goog_lfWQhaHxLGYrxrySNKCNlHLQKaa';
