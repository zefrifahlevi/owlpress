import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  final String initialName;
  final String initialEmail;
  final String initialJoined;
  final String initialInterest;
  final Function(String, String, String, String) onSave;

  const SettingScreen({
    super.key,
    required this.initialName,
    required this.initialEmail,
    required this.initialJoined,
    required this.initialInterest,
    required this.onSave,
  });

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _joinedController;
  late TextEditingController _interestController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _emailController = TextEditingController(text: widget.initialEmail);
    _joinedController = TextEditingController(text: widget.initialJoined);
    _interestController = TextEditingController(text: widget.initialInterest);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _joinedController.dispose();
    _interestController.dispose();
    super.dispose();
  }

  void _saveSettings() {
    widget.onSave(
      _nameController.text,
      _emailController.text,
      _joinedController.text,
      _interestController.text,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDEFD9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Setting",
          style: TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _joinedController,
              decoration: const InputDecoration(labelText: "Joined"),
            ),
            TextField(
              controller: _interestController,
              decoration: const InputDecoration(labelText: "Interest"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveSettings,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }
}
