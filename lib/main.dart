import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import 'data.dart';
import 'halaman_detail.dart';
import 'halaman_katalog.dart';
import 'halaman_kategori.dart';
import 'halaman_keranjang.dart';
import 'halaman_tentang.dart';
import 'keranjang_cubit.dart';

void main() => runApp(
      BlocProvider(
        create: (_) => KeranjangCubit(),
        child: const KatalogApp(),
      ),
    );

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => KerangkaNavigasi(shell: shell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HalamanKatalog(),
              routes: [
                GoRoute(
                  path: 'produk/:id',
                  builder: (context, state) {
                    final id = int.tryParse(state.pathParameters['id'] ?? '');
                    return HalamanDetail(
                      produk: id == null ? null : cariProduk(id),
                    );
                  },
                ),
                GoRoute(
                  path: 'kategori/:nama',
                  builder: (context, state) => HalamanKategori(
                    nama: state.pathParameters['nama'] ?? '',
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/tentang',
              builder: (context, state) => const HalamanTentang(),
            ),
          ],
        ),
        // BARU: cabang ketiga
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/keranjang',
              builder: (context, state) => const HalamanKeranjang(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class KatalogApp extends StatelessWidget {
  const KatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Oleh-Oleh Medan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6D4C41)),
      ),
      routerConfig: _router,
    );
  }
}

class KerangkaNavigasi extends StatelessWidget {
  const KerangkaNavigasi({super.key, required this.shell});

  final StatefulNavigationShell shell;

  void _pilih(int i) =>
      shell.goBranch(i, initialLocation: i == shell.currentIndex);

  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.sizeOf(context).width;

    // BARU: versi Cubit
    final jumlah = context.select((KeranjangCubit c) => c.state.jumlahItem);
    final ikonKeranjang = Badge.count(
      count: jumlah,
      isLabelVisible: jumlah > 0,
      child: const Icon(Icons.shopping_cart_outlined),
    );

    if (lebar >= 840) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: shell.currentIndex,
              onDestinationSelected: _pilih,
              labelType: NavigationRailLabelType.all,
              destinations: [
                const NavigationRailDestination(
                  icon: Icon(Icons.storefront_outlined),
                  selectedIcon: Icon(Icons.storefront),
                  label: Text('Katalog'),
                ),
                const NavigationRailDestination(
                  icon: Icon(Icons.info_outline),
                  selectedIcon: Icon(Icons.info),
                  label: Text('Tentang'),
                ),
                NavigationRailDestination(
                  icon: ikonKeranjang,
                  label: const Text('Keranjang'),
                ),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(child: shell),
          ],
        ),
      );
    }

    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: _pilih,
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.storefront_outlined),
            selectedIcon: Icon(Icons.storefront),
            label: 'Katalog',
          ),
          const NavigationDestination(
            icon: Icon(Icons.info_outline),
            selectedIcon: Icon(Icons.info),
            label: 'Tentang',
          ),
          NavigationDestination(icon: ikonKeranjang, label: 'Keranjang'),
        ],
      ),
    );
  }
}