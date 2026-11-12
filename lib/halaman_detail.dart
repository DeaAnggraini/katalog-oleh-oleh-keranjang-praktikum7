import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'data.dart';
import 'keranjang_model.dart';

class HalamanDetail extends StatelessWidget {
  const HalamanDetail({super.key, required this.produk});

  final Produk? produk; // null bila ID di URL tidak dikenal

  @override
  Widget build(BuildContext context) {
    final p = produk;
    if (p == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Produk tidak ditemukan')),
        body: Center(
          child: FilledButton(
            onPressed: () => context.go('/'),
            child: const Text('Kembali ke katalog'),
          ),
        ),
      );
    }

    // Harus diletakkan setelah pengecekan null, karena butuh p.id
    final diKeranjang = context.select((KeranjangModel k) => k.jumlahDari(p.id));

    final skema = Theme.of(context).colorScheme;
    final teks = Theme.of(context).textTheme;
    final gambar = AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        color: p.warna.withValues(alpha: 0.15),
        child: Hero(
          tag: 'produk-${p.id}', // harus sama dengan tag di KartuProduk
          child: Icon(p.ikon, size: 120, color: p.warna),
        ),
      ),
    );
    final info = Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(p.nama, style: teks.headlineSmall),
          const SizedBox(height: 8),
          ActionChip(
            label: Text(p.kategori),
            onPressed: () =>
                context.go('/kategori/${Uri.encodeComponent(p.kategori)}'),
          ),
          const SizedBox(height: 8),
          Text(
            p.harga.rupiah,
            style: teks.titleLarge?.copyWith(color: skema.primary),
          ),
          const SizedBox(height: 16),
          Text(p.deskripsi, style: teks.bodyLarge),

          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => context.read<KeranjangModel>().tambah(p),
            icon: const Icon(Icons.add_shopping_cart),
            label: Text(
              diKeranjang == 0
                  ? 'Tambah ke keranjang'
                  : 'Tambah lagi ($diKeranjang di keranjang)',
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text(p.nama)),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 700) {
            // Lebar: gambar dan info berdampingan
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: gambar),
                Expanded(child: SingleChildScrollView(child: info)),
              ],
            );
          }
          // Sempit: gambar di atas, info di bawah
          return ListView(children: [gambar, info]);
        },
      ),
    );
  }
}