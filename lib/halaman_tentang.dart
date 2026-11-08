import 'package:material_ui/material_ui.dart';

class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;
    final teks = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Toko')),
      body: ListView(
        children: [
          SizedBox(
            height: 180,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ColoredBox(color: skema.primaryContainer),
                ),
                Positioned(
                  right: -20,
                  bottom: -24,
                  child: Icon(
                    Icons.storefront,
                    size: 160,
                    color: skema.primary.withValues(alpha: 0.2),
                  ),
                ),
                Positioned(
                  left: 20,
                  bottom: 20,
                  child: Text('Oleh-Oleh Medan', style: teks.headlineSmall),
                ),
              ],
            ),
          ),
          const ListTile(
            leading: Icon(Icons.schedule),
            title: Text('Buka setiap hari'),
            subtitle: Text('08.00–21.00 WIB'),
          ),
          const ListTile(
            leading: Icon(Icons.place_outlined),
            title: Text('Jl. Contoh No. 1, Medan'),
          ),
          const ListTile(
            leading: Icon(Icons.local_shipping_outlined),
            title: Text('Pengiriman ke seluruh Indonesia'),
          ),
        ],
      ),
    );
  }
}