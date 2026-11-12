import 'package:flutter/foundation.dart';
import 'data.dart';

class ItemKeranjang {
  const ItemKeranjang(this.produk, this.jumlah);
  final Produk produk;
  final int jumlah;
  int get subtotal => produk.harga * jumlah;
}

class KeranjangModel extends ChangeNotifier {
  final Map<int, int> _isi = {}; // id produk -> jumlah

  List<ItemKeranjang> get item => [
        for (final e in _isi.entries)
          ItemKeranjang(cariProduk(e.key)!, e.value),
      ];

  int get jumlahItem => _isi.values.fold(0, (a, b) => a + b);
  int get total => item.fold(0, (s, i) => s + i.subtotal);
  int jumlahDari(int idProduk) => _isi[idProduk] ?? 0;

  void tambah(Produk p) {
    _isi.update(p.id, (n) => n + 1, ifAbsent: () => 1);
    notifyListeners();
  }

  void kurangi(Produk p) {
    final n = _isi[p.id];
    if (n == null) return;
    if (n <= 1) {
      _isi.remove(p.id);
    } else {
      _isi[p.id] = n - 1;
    }
    notifyListeners();
  }

  void kosongkan() {
    _isi.clear();
    notifyListeners();
  }
}