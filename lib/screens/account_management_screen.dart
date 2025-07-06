// lib/screens/account_management_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracer_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AccountManagementScreen extends StatelessWidget {
  const AccountManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Menambahkan tombol kembali secara eksplisit
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Kembali ke halaman sebelumnya
            context.pop();
          },
        ),
        title: const Text('Manajemen Akun'),
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.lock_reset_outlined),
            title: const Text('Reset Password'),
            onTap: () {
              context.go('/forgot-password');
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.delete_forever_outlined, color: Colors.red),
            title: const Text(
              'Tutup Akun',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              _showCloseAccountDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showCloseAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Tutup Akun'),
          content: const Text(
              'Apakah Anda yakin ingin menutup akun secara permanen? Tindakan ini tidak dapat diurungkan.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child:
                  const Text('Tutup Akun', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Provider.of<AuthProvider>(context, listen: false)
                    .deleteAccount();
              },
            ),
          ],
        );
      },
    );
  }
}
