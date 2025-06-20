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
    final judul = _judulController.text;
    final kategori = _kategoriController.text;
    final gambar = _gambarController.text;
    final konten = _kontenController.text;

    if (judul.isNotEmpty && kategori.isNotEmpty && gambar.isNotEmpty && konten.isNotEmpty) {
      setState(() {
        _artikelList.add({
          'judul': judul,
          'kategori': kategori,
          'gambar': gambar,
          'konten': konten,
        });
        _judulController.clear();
        _kategoriController.clear();
        _gambarController.clear();
        _kontenController.clear();
      });
    }
  }

  void _editArtikel(int index) {
    final artikel = _artikelList[index];
    _judulController.text = artikel['judul']!;
    _kategoriController.text = artikel['kategori']!;
    _gambarController.text = artikel['gambar']!;
    _kontenController.text = artikel['konten']!;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Artikel'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: _judulController, decoration: const InputDecoration(labelText: 'Judul Artikel')),
              TextField(controller: _kategoriController, decoration: const InputDecoration(labelText: 'Kategori')),
              TextField(controller: _gambarController, decoration: const InputDecoration(labelText: 'Gambar')),
              TextField(controller: _kontenController, decoration: const InputDecoration(labelText: 'Konten')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _artikelList[index] = {
                  'judul': _judulController.text,
                  'kategori': _kategoriController.text,
                  'gambar': _gambarController.text,
                  'konten': _kontenController.text,
                };
              });
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
        ],
      ),
    );
  }

  void _hapusArtikel(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Konfirmasi Hapus?'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _artikelList.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text('YA'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('TDK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDEFD9),
      appBar: AppBar(
        title: const Text('Artikel Anda'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Add Artikel'),
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextField(controller: _judulController, decoration: const InputDecoration(labelText: 'Judul Artikel')),
                          TextField(controller: _kategoriController, decoration: const InputDecoration(labelText: 'Kategori')),
                          TextField(controller: _gambarController, decoration: const InputDecoration(labelText: 'Gambar')),
                          TextField(controller: _kontenController, decoration: const InputDecoration(labelText: 'Konten')),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          _tambahArtikel();
                          Navigator.pop(context);
                        },
                        child: const Text('Tambah'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Batal'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Tambah Artikel Baru (+)', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _artikelList.length,
                itemBuilder: (_, index) {
                  final artikel = _artikelList[index];
                  return ListTile(
                    title: Text(artikel['judul']!),
                    subtitle: Text(artikel['kategori']!),
                    trailing: Wrap(
                      spacing: 12,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.black54),
                          onPressed: () => _editArtikel(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _hapusArtikel(index),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
