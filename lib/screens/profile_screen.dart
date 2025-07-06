// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracer_app/providers/auth_provider.dart';
import 'package:mood_tracer_app/widgets/editable_profile_tile.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;

  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _bioController;
  late TextEditingController _phoneController;
  late TextEditingController _genderController;
  late TextEditingController _birthDateController;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller di awal
    _initializeControllers();
  }

  // Fungsi untuk inisialisasi atau mereset controller
  void _initializeControllers() {
    final profile =
        Provider.of<AuthProvider>(context, listen: false).currentUserProfile;
    _nameController = TextEditingController(text: profile?.name);
    _usernameController = TextEditingController(text: profile?.username);
    _bioController = TextEditingController(text: profile?.bio);
    _phoneController = TextEditingController(text: profile?.phoneNumber);
    _genderController = TextEditingController(text: profile?.gender);
    _birthDateController = TextEditingController(text: profile?.birthDate);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    _phoneController.dispose();
    _genderController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  void _toggleEdit(bool editing) {
    setState(() {
      _isEditing = editing;
    });
  }

  void _saveProfile() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final newProfile = UserProfile(
      name: _nameController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      phoneNumber: _phoneController.text,
      gender: _genderController.text,
      birthDate: _birthDateController.text,
    );
    authProvider.updateProfile(newProfile);
    _toggleEdit(false); // Keluar dari mode edit setelah menyimpan
  }

  // Fungsi baru untuk membatalkan editan
  void _cancelEdit() {
    setState(() {
      // Kembalikan nilai controller ke data semula
      _initializeControllers();
      _isEditing = false; // Keluar dari mode edit
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final userProfile = authProvider.currentUserProfile;
        final userEmail = authProvider.currentUserEmail ?? 'Tidak tersedia';

        if (userProfile == null) {
          return const Scaffold(
            body: Center(child: Text("Profil tidak ditemukan.")),
          );
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
            title: const Text('Profil Pengguna'),
            actions: [
              // Logika untuk menampilkan tombol di AppBar
              _isEditing
                  ? Row(
                      children: [
                        // Tombol Batal
                        TextButton(
                          onPressed: _cancelEdit,
                          child: Text(
                            'Batal',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        ),
                        // Tombol Simpan
                        TextButton(
                          onPressed: _saveProfile,
                          child: Text(
                            'Simpan',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  : TextButton(
                      // Tombol Edit
                      onPressed: () => _toggleEdit(true),
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 16,
                        ),
                      ),
                    ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Text('Info Profil',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              EditableProfileTile(
                icon: Icons.person_outline,
                title: 'Nama',
                value: userProfile.name,
                isEditing: _isEditing,
                controller: _nameController,
              ),
              EditableProfileTile(
                icon: Icons.account_circle_outlined,
                title: 'Username',
                value: userProfile.username,
                isEditing: _isEditing,
                controller: _usernameController,
              ),
              EditableProfileTile(
                icon: Icons.info_outline,
                title: 'Bio',
                value: userProfile.bio,
                isEditing: _isEditing,
                controller: _bioController,
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text('Info Pribadi',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              EditableProfileTile(
                icon: Icons.badge_outlined,
                title: 'User ID',
                value: userEmail.hashCode.toString(),
                isEditing: false,
                controller: TextEditingController(),
                isEditable: false,
              ),
              EditableProfileTile(
                icon: Icons.email_outlined,
                title: 'E-mail',
                value: userEmail,
                isEditing: false,
                controller: TextEditingController(),
                isEditable: false,
              ),
              EditableProfileTile(
                icon: Icons.phone_outlined,
                title: 'Nomor HP',
                value: userProfile.phoneNumber,
                isEditing: _isEditing,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
              ),
              EditableProfileTile(
                icon: Icons.wc_outlined,
                title: 'Jenis Kelamin',
                value: userProfile.gender,
                isEditing: _isEditing,
                controller: _genderController,
              ),
              EditableProfileTile(
                icon: Icons.cake_outlined,
                title: 'Tanggal Lahir',
                value: userProfile.birthDate,
                isEditing: _isEditing,
                controller: _birthDateController,
              ),
            ],
          ),
        );
      },
    );
  }
}
