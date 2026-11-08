import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import 'data.dart';

class HalamanKatalog extends StatelessWidget {
  const HalamanKatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Oleh-Oleh Medan')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Jumlah kolom mengikuti lebar ruang yang tersedia
          final kolom = switch (constraints.maxWidth) {
            < 600 => 2,
            < 900 => 3,
            _ => 4,
          };
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: kolom,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemCount: daftarProduk.length,
            itemBuilder: (context, i) => KartuProduk(produk: daftarProduk[i]),
          );
        },
      ),
    );
  }
}

class KartuProduk extends StatelessWidget {
  const KartuProduk({super.key, required this.produk});

  final Produk produk;

  @override
  Widget build(BuildContext context) {
    final teks = Theme.of(context).textTheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.go('/produk/${produk.id}'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: produk.warna.withValues(alpha: 0.15),
                child: Icon(produk.ikon, size: 56, color: produk.warna),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    produk.nama,
                    style: teks.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(produk.harga.rupiah, style: teks.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}