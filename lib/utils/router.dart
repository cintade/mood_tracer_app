// lib/utils/router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracer_app/providers/auth_provider.dart';
import '../screens/home_screen.dart';
import '../screens/history_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/main_screen.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/forgot_password_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/account_management_screen.dart';

class AppRouter {
  final AuthProvider authProvider;

  AppRouter(this.authProvider);

  late final GoRouter router = GoRouter(
    initialLocation: '/login',
    refreshListenable: authProvider,
    routes: [
      // Rute-rute yang berada di luar BottomNavigationBar (tidak pakai shell)
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // Rute-rute yang menggunakan MainScreen (dengan BottomNavigationBar)
      ShellRoute(
        builder: (context, state, child) {
          return MainScreen(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => HomeScreen(),
          ),
          GoRoute(
            path: '/history',
            builder: (context, state) => const HistoryScreen(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
          ),
          // Sub-rute dari /settings sekarang berada di luar GoRoute-nya
          // agar tidak terjadi konflik builder
          GoRoute(
            path: '/settings/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: '/settings/account',
            builder: (context, state) => const AccountManagementScreen(),
          ),
        ],
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final bool isAuthenticated = authProvider.isAuthenticated;
      // Perbarui pengecekan halaman otentikasi
      final isAuthPage = state.matchedLocation.startsWith('/login') ||
          state.matchedLocation.startsWith('/signup') ||
          state.matchedLocation.startsWith('/forgot-password');

      if (!isAuthenticated && !isAuthPage) {
        return '/login';
      }

      if (isAuthenticated && isAuthPage) {
        return '/';
      }

      return null;
    },
  );
}
