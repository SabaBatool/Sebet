import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfileDialog extends StatefulWidget {
  final User user;
  final Map<String, dynamic> initialData;
  final Function() onUpdate;

  const EditProfileDialog({
    Key? key,
    required this.user,
    required this.initialData,
    required this.onUpdate,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileDialogState createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  late TextEditingController _firstNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _descriptionController; // Updated name

  @override
  void initState() {
    super.initState();
    _firstNameController =
        TextEditingController(text: widget.initialData['firstName']);
    _emailController = TextEditingController(text: widget.initialData['email']);
    _phoneController = TextEditingController(text: widget.initialData['phone']);
    _descriptionController = TextEditingController(
        text: widget.initialData['description']); // Updated name
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Profile'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(widget.user.uid)
                .update({
              'firstName': _firstNameController.text,
              'email': _emailController.text,
              'phone': _phoneController.text,
              'description': _descriptionController.text, // Updated key
            });

            widget.onUpdate();

            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
