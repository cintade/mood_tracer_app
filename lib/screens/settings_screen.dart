// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracer_app/providers/auth_provider.dart';
import 'package:mood_tracer_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: [
          // Mode Gelap
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              bool isDarkMode = themeProvider.themeMode == ThemeMode.dark;
              return ListTile(
                leading: const Icon(Icons.brightness_6_outlined),
                title: const Text('Mode Gelap'),
                trailing: Switch.adaptive(
                  value: isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
                  },
                ),
              );
            },
          ),

          // Tombol Profil Pengguna
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Profil Pengguna'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // DIUBAH: Gunakan push() agar bisa kembali dengan tombol back
              context.push('/settings/profile');
            },
          ),

          // Tombol Manajemen Akun
          ListTile(
            leading: const Icon(Icons.manage_accounts_outlined),
            title: const Text('Manajemen Akun'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // DIUBAH: Gunakan push() agar bisa kembali dengan tombol back
              context.push('/settings/account');
            },
          ),

          const Divider(),

          // Tombol Keluar
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Keluar', style: TextStyle(color: Colors.red)),
            onTap: () {
              Provider.of<AuthProvider>(context, listen: false).signOut();
            },
          ),
        ],
      ),
    );
  }
}
