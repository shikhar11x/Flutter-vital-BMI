import 'package:firebase_core/firebase_core.dart';
import '../config/firebase_options.dart';

/// Firebase initialization service
class FirebaseService {
  static Future<void> initialize() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      rethrow;
    }
  }
}
