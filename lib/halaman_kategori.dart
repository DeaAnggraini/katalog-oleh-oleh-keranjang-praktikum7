import 'package:material_ui/material_ui.dart';

import 'data.dart';
import 'halaman_katalog.dart';

class HalamanKategori extends StatelessWidget {
  const HalamanKategori({super.key, required this.nama});

  final String nama; // dari URL /kategori/:nama

  @override
  Widget build(BuildContext context) {
    final hasil = daftarProduk
        .where((p) => p.kategori.toLowerCase() == nama.toLowerCase())
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text('Kategori: $nama')),
      body: hasil.isEmpty
          ? const Center(child: Text('Tidak ada produk di kategori ini'))
          : GridProduk(produk: hasil),
    );
  }
}