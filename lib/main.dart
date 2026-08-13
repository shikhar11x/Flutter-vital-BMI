import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/theme/app_theme.dart';
import 'services/firebase_service.dart';
import 'services/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Step 1: Load environment variables (with error handling for web)
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    // Continue anyway - use default values
  }

  // Step 2: Initialize Firebase
  try {
    await FirebaseService.initialize();
  } catch (e) {
    // Firebase initialization warning
  }

  // Step 3: Initialize Hive local storage
  try {
    await HiveService.initialize();
  } catch (e) {
    // Hive initialization warning
  }

  runApp(const ProviderScope(child: VitalBMIApp()));
}

/// Main App Widget
class VitalBMIApp extends ConsumerWidget {
  const VitalBMIApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'VitalBMI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme(),
      home: const HomeScreen(),
    );
  }
}

/// Temporary Home Screen (will be replaced with router in Phase 4)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.favorite, color: Color(0xFF8B5CF6), size: 64),
            const SizedBox(height: 16),
            Text('VitalBMI', style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(height: 8),
            Text(
              'Smart BMI & Weight Tracker',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 48),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1F2E),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    '✅ Phase 1: Core Setup',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '✅ Phase 2: Data Models',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '✅ Phase 3: State Management',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '🚀 Phase 4: UI Screens (Next)',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFF8B5CF6),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
