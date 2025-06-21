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
  late Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = {
      'Name': TextEditingController(text: widget.initialName),
      'Email': TextEditingController(text: widget.initialEmail),
      'Joined': TextEditingController(text: widget.initialJoined),
      'Interest': TextEditingController(text: widget.initialInterest),
    };
  }

  @override
  void dispose() {
    _controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  void _editField(String label) {
    final controller = _controllers[label]!;

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: const Color(0xFF2A3C30),
            title: Text(
              "Edit $label",
              style: const TextStyle(color: Color(0xFFD1B97F)),
            ),
            content: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1E2D23),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFD1B97F)),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFFE1C78F),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: label,
                labelStyle: const TextStyle(color: Colors.white70),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Batal",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD1B97F),
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  setState(() {});
                  Navigator.pop(context);
                },
                child: const Text("Simpan"),
              ),
            ],
          ),
    );
  }

  void _saveSettings() {
    widget.onSave(
      _controllers['Name']!.text,
      _controllers['Email']!.text,
      _controllers['Joined']!.text,
      _controllers['Interest']!.text,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E2D23),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFD1B97F)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Setting",
          style: TextStyle(
            color: Color(0xFFD1B97F),
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ..._controllers.entries.map((entry) {
            return ListTile(
              tileColor: const Color(0xFF2A3C30),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text(
                entry.key,
                style: const TextStyle(color: Colors.white70),
              ),
              subtitle: Text(
                entry.value.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit, color: Color(0xFFD1B97F)),
                onPressed: () => _editField(entry.key),
              ),
            );
          }),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: _saveSettings,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD1B97F),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "SIMPAN",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
