import 'package:flutter/material.dart';

class AddArtikelScreen extends StatefulWidget {
  const AddArtikelScreen({super.key});

  @override
  State<AddArtikelScreen> createState() => _AddArtikelScreenState();
}

class _AddArtikelScreenState extends State<AddArtikelScreen> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _kategoriController = TextEditingController();
  final TextEditingController _gambarController = TextEditingController();
  final TextEditingController _kontenController = TextEditingController();

  final List<Map<String, String>> _artikelList = [];

  void _tambahArtikel() {
    if (_judulController.text.isEmpty ||
        _kategoriController.text.isEmpty ||
        _gambarController.text.isEmpty ||
        _kontenController.text.isEmpty) {
      return;
    }

    setState(() {
      _artikelList.add({
        'judul': _judulController.text,
        'kategori': _kategoriController.text,
        'gambar': _gambarController.text,
        'konten': _kontenController.text,
      });

      _judulController.clear();
      _kategoriController.clear();
      _gambarController.clear();
      _kontenController.clear();
    });
  }

  void _editArtikel(int index) {
    final artikel = _artikelList[index];
    _judulController.text = artikel['judul']!;
    _kategoriController.text = artikel['kategori']!;
    _gambarController.text = artikel['gambar']!;
    _kontenController.text = artikel['konten']!;

    _showArtikelDialog(isEdit: true, index: index);
  }

  void _hapusArtikel(int index) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: const Color(0xFF2A3C30),
            title: const Text(
              'Konfirmasi Hapus?',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() => _artikelList.removeAt(index));
                  Navigator.pop(context);
                },
                child: const Text(
                  'YA',
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'TIDAK',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
    );
  }

  void _showArtikelDialog({bool isEdit = false, int? index}) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: const Color(0xFF1E2D23),
            title: Text(
              isEdit ? 'Edit Artikel' : 'Tambah Artikel',
              style: const TextStyle(color: Color(0xFFD1B97F)),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  _inputField(_judulController, 'Judul Artikel'),
                  _inputField(_kategoriController, 'Kategori'),
                  _inputField(_gambarController, 'URL Gambar'),
                  _inputField(_kontenController, 'Konten'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (isEdit && index != null) {
                    setState(() {
                      _artikelList[index] = {
                        'judul': _judulController.text,
                        'kategori': _kategoriController.text,
                        'gambar': _gambarController.text,
                        'konten': _kontenController.text,
                      };
                    });
                  } else {
                    _tambahArtikel();
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  isEdit ? 'Simpan' : 'Tambah',
                  style: const TextStyle(color: Color(0xFFD1B97F)),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Batal',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
    );
  }

  Widget _inputField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: const Color(0xFF2A3C30),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFD1B97F)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFD1B97F)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E2D23),
      appBar: AppBar(
        title: const Text(
          'Artikel Anda',
          style: TextStyle(color: Color(0xFFD1B97F)),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFFD1B97F)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.add, color: Colors.black),
              label: const Text(
                'Tambah Artikel Baru',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD1B97F),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => _showArtikelDialog(),
            ),
            const SizedBox(height: 16),
            Expanded(
              child:
                  _artikelList.isEmpty
                      ? const Center(
                        child: Text(
                          'Belum ada artikel.',
                          style: TextStyle(color: Colors.white70),
                        ),
                      )
                      : ListView.builder(
                        itemCount: _artikelList.length,
                        itemBuilder: (_, index) {
                          final artikel = _artikelList[index];
                          return Card(
                            color: const Color(0xFF2A3C30),
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Text(
                                artikel['judul']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                artikel['kategori']!,
                                style: const TextStyle(color: Colors.white70),
                              ),
                              trailing: Wrap(
                                spacing: 8,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.amber,
                                    ),
                                    onPressed: () => _editArtikel(index),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                    ),
                                    onPressed: () => _hapusArtikel(index),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
