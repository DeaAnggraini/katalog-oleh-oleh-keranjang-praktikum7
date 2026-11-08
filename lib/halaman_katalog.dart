import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import 'data.dart';

class HalamanKatalog extends StatefulWidget {
  const HalamanKatalog({super.key});

  @override
  State<HalamanKatalog> createState() => _HalamanKatalogState();
}

class _HalamanKatalogState extends State<HalamanKatalog> {
  String? _kategori; // null = tampilkan semua

  @override
  Widget build(BuildContext context) {
    // Daftar kategori unik diambil dari data
    final semuaKategori = daftarProduk.map((p) => p.kategori).toSet().toList();

    final tampil = _kategori == null
        ? daftarProduk
        : daftarProduk.where((p) => p.kategori == _kategori).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Oleh-Oleh Medan')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 8,
                children: [
                  FilterChip(
                    label: const Text('Semua'),
                    selected: _kategori == null,
                    onSelected: (_) => setState(() => _kategori = null),
                  ),
                  for (final k in semuaKategori)
                    FilterChip(
                      label: Text(k),
                      selected: _kategori == k,
                      onSelected: (dipilih) =>
                          setState(() => _kategori = dipilih ? k : null),
                    ),
                ],
              ),
            ),
          ),
          Expanded(child: GridProduk(produk: tampil)),
        ],
      ),
    );
  }
}

/// Grid responsif; dipakai di halaman katalog dan halaman kategori.
class GridProduk extends StatelessWidget {
  const GridProduk({super.key, required this.produk});

  final List<Produk> produk;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
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
          itemCount: produk.length,
          itemBuilder: (context, i) => KartuProduk(produk: produk[i]),
        );
      },
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
                // Tantangan 3: Hero membungkus ikon
                child: Hero(
                  tag: 'produk-${produk.id}',
                  child: Icon(produk.ikon, size: 56, color: produk.warna),
                ),
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