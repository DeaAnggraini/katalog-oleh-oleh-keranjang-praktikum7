import 'package:material_ui/material_ui.dart';

class Produk {
  const Produk({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.deskripsi,
    required this.ikon,
    required this.warna,
  });

  final int id;
  final String nama;
  final String kategori;
  final int harga;
  final String deskripsi;
  final IconData ikon;
  final Color warna;
}

const daftarProduk = <Produk>[
  Produk(id: 1, nama: 'Kopi Sidikalang', kategori: 'Minuman', harga: 45000,
      deskripsi: 'Kopi robusta khas Dairi, sangrai sedang, 250 g.',
      ikon: Icons.coffee, warna: Color(0xFF6D4C41)),
  Produk(id: 2, nama: 'Bolu Meranti', kategori: 'Kue', harga: 80000,
      deskripsi: 'Bolu gulung lembut dengan isian keju dan cokelat.',
      ikon: Icons.cake, warna: Color(0xFFC2185B)),
  Produk(id: 3, nama: 'Bika Ambon', kategori: 'Kue', harga: 65000,
      deskripsi: 'Kue berserat khas Medan dengan aroma daun jeruk.',
      ikon: Icons.bakery_dining, warna: Color(0xFFF9A825)),
  Produk(id: 4, nama: 'Teh Kayu Aro', kategori: 'Minuman', harga: 25000,
      deskripsi: 'Teh hitam dari dataran tinggi, 100 g.',
      ikon: Icons.emoji_food_beverage, warna: Color(0xFF2E7D32)),
  Produk(id: 5, nama: 'Sirup Markisa', kategori: 'Minuman', harga: 35000,
      deskripsi: 'Sirup buah markisa asli Berastagi, 620 ml.',
      ikon: Icons.local_drink, warna: Color(0xFFEF6C00)),
  Produk(id: 6, nama: 'Keripik Ubi Balado', kategori: 'Camilan', harga: 20000,
      deskripsi: 'Keripik ubi renyah dengan bumbu balado pedas manis.',
      ikon: Icons.set_meal, warna: Color(0xFFB3261E)),
];

Produk? cariProduk(int id) {
  for (final p in daftarProduk) {
    if (p.id == id) return p;
  }
  return null;
}

extension Rupiah on int {
  String get rupiah {
    final pola = RegExp(r'\B(?=(\d{3})+(?!\d))');
    return 'Rp${toString().replaceAllMapped(pola, (m) => '.')}';
  }
}