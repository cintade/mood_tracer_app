// lib/widgets/editable_profile_tile.dart
import 'package:flutter/material.dart';

class EditableProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool isEditing;
  final TextEditingController controller;
  final bool isEditable;
  final TextInputType keyboardType;

  const EditableProfileTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.isEditing,
    required this.controller,
    this.isEditable = true,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    // Atur teks awal pada controller saat mode edit aktif
    if (isEditing && isEditable) {
      controller.text = value;
    }

    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: isEditing && isEditable
          ? TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: const InputDecoration(
                isDense: true,
                border: UnderlineInputBorder(),
              ),
            )
          : Text(value),
    );
  }
}
