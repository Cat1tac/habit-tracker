// lib/app.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_colors.dart';
import 'providers/habit_provider.dart';
import 'providers/streak_provider.dart';
import 'providers/challenge_provider.dart';
import 'providers/ai_provider.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/habits/create_habit_screen.dart';
import 'screens/heatmap/heatmap_screen.dart';
import 'screens/dashboard/insight_dashboard_screen.dart';
import 'screens/challenges/challenges_screen.dart';
import 'screens/reflections/weekly_reflection_screen.dart';
import 'screens/badges/badges_screen.dart';
import 'screens/ai_buddy/ai_buddy_screen.dart';

class HabitMasteryApp extends StatelessWidget {
  const HabitMasteryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HabitProvider()),
        ChangeNotifierProvider(create: (_) => StreakProvider()),
        ChangeNotifierProvider(create: (_) => ChallengeProvider()),
        ChangeNotifierProvider(create: (_) => AiProvider()),
      ],
      child: MaterialApp(
        title: 'Habit Mastery League',
        debugShowCheckedModeBanner: false,
        theme: _buildTheme(),
        initialRoute: '/splash',
        routes: {
          '/splash': (_) => const SplashScreen(),
          '/home': (_) => const HomeScreen(),
          '/create-habit': (_) => const CreateHabitScreen(),
          '/heatmap': (_) => const HeatmapScreen(),
          '/dashboard': (_) => const InsightDashboardScreen(),
          '/challenges': (_) => const ChallengesScreen(),
          '/reflection': (_) => const WeeklyReflectionScreen(),
          '/badges': (_) => const BadgesScreen(),
          '/ai-buddy': (_) => const AiBuddyScreen(),
        },
      ),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.backgroundCard,
      ),
      scaffoldBackgroundColor: AppColors.backgroundDark,
      cardColor: AppColors.backgroundCard,
      fontFamily: 'Poppins', // Add Poppins to pubspec assets
    );
  }
}