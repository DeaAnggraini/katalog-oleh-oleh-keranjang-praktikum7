import 'package:flutter_bloc/flutter_bloc.dart';
import 'data.dart';

class KeranjangState {
  const KeranjangState([this.isi = const {}, this.pesananSelesai = false]);
  final Map<int, int> isi; // id produk -> jumlah
  final bool pesananSelesai; // true hanya tepat setelah checkout

  int get jumlahItem => isi.values.fold(0, (a, b) => a + b);
  int get total => isi.entries
      .fold(0, (s, e) => s + cariProduk(e.key)!.harga * e.value);
}

class KeranjangCubit extends Cubit<KeranjangState> {
  KeranjangCubit() : super(const KeranjangState());

  void tambah(Produk p) {
    final baru = Map<int, int>.of(state.isi)
      ..update(p.id, (n) => n + 1, ifAbsent: () => 1);
    emit(KeranjangState(baru));
  }

  void kurangi(Produk p) {
    final n = state.isi[p.id];
    if (n == null) return;
    final baru = Map<int, int>.of(state.isi);
    if (n <= 1) {
      baru.remove(p.id);
    } else {
      baru[p.id] = n - 1;
    }
    emit(KeranjangState(baru));
  }

  void kosongkan() => emit(const KeranjangState());

  void checkout() => emit(const KeranjangState({}, true));
}