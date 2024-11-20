import 'package:shared_preferences/shared_preferences.dart';

class Sharedprefsservice {
static final Sharedprefsservice _instance = Sharedprefsservice._internal();
  late SharedPreferences prefs;
  factory Sharedprefsservice() {
    return _instance;
  }
  Sharedprefsservice._internal();

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
