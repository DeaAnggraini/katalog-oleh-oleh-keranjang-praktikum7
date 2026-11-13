import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data.dart';
import 'keranjang_cubit.dart';

class HalamanKeranjang extends StatelessWidget {
  const HalamanKeranjang({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<KeranjangCubit, KeranjangState>(
      listenWhen: (lama, baru) => baru.pesananSelesai,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pesanan dibuat (simulasi)')),
        );
      },
      child: BlocBuilder<KeranjangCubit, KeranjangState>(
        builder: (context, state) {
          final isi = state.isi.entries.toList();
          return Scaffold(
            appBar: AppBar(title: const Text('Keranjang')),
            body: isi.isEmpty
                ? const Center(child: Text('Keranjang masih kosong'))
                : ListView.separated(
                    itemCount: isi.length,
                    separatorBuilder: (context, i) => const Divider(height: 1),
                    itemBuilder: (context, i) {
                      final produk = cariProduk(isi[i].key)!;
                      final jumlah = isi[i].value;
                      return ListTile(
                        leading: Icon(produk.ikon, color: produk.warna),
                        title: Text(produk.nama),
                        subtitle: Text((produk.harga * jumlah).rupiah),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => context
                                  .read<KeranjangCubit>()
                                  .kurangi(produk),
                            ),
                            Text('$jumlah'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () =>
                                  context.read<KeranjangCubit>().tambah(produk),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
            bottomNavigationBar: isi.isEmpty
                ? null
                : SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Total ${state.total.rupiah}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          FilledButton(
                            onPressed: () =>
                                context.read<KeranjangCubit>().checkout(),
                            child: const Text('Checkout'),
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}