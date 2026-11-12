import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'data.dart';
import 'keranjang_model.dart';

class HalamanKeranjang extends StatelessWidget {
  const HalamanKeranjang({super.key});

  @override
  Widget build(BuildContext context) {
    final keranjang = context.watch<KeranjangModel>(); // rebuild bila berubah
    final item = keranjang.item;

    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang')),
      body: item.isEmpty
          ? const Center(child: Text('Keranjang masih kosong'))
          : ListView.separated(
              itemCount: item.length,
              separatorBuilder: (context, i) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final it = item[i];
                return ListTile(
                  leading: Icon(it.produk.ikon, color: it.produk.warna),
                  title: Text(it.produk.nama),
                  subtitle: Text(it.subtotal.rupiah),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () =>
                            context.read<KeranjangModel>().kurangi(it.produk),
                      ),
                      Text('${it.jumlah}'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () =>
                            context.read<KeranjangModel>().tambah(it.produk),
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: item.isEmpty
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Total ${keranjang.total.rupiah}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        context.read<KeranjangModel>().kosongkan();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Pesanan dibuat (simulasi)'),
                          ),
                        );
                      },
                      child: const Text('Checkout'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}